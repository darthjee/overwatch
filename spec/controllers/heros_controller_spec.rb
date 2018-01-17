require 'spec_helper'

describe HerosController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Hero. As you add validations to Hero, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      'name' => 'd.v.a',
      'real_name' => 'Hana Song',
      'health' => 100,
      'armor' => 300,
      'shield' => 50
    }
  end

  let(:invalid_attributes) do
    {}
  end

  let(:expected_attributes) do
    {
      'id' => 1,
      'name' => 'Mercy',
      'real_name' => 'Angela Ziegler',
      'health' => 100,
      'armor' => 150,
      'shield' => 150
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HerosController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:hero) { heros(:mercy) }
  let(:response_json) { JSON.parse(response.body) }

  describe "GET #index" do
    let(:parameters) { { format: :json } }
    before { get :index, params: parameters }

    context 'when requestin the REST api' do
      it { expect(response).to be_success }

      it 'returns all heros' do
        expect(response_json.mapk('name')).to eq(['Mercy'])
      end

      it 'returns all the information' do
        expect(response_json).to include(hash_including(expected_attributes))
      end
    end

    context 'when requesting the templates' do
      let(:parameters) { { ajax: true } }
      it { expect(response).to render_template('heros/index') }
    end
  end

  describe "GET #show" do
    before { get :show, params: parameters }

    context 'when requestin the REST api' do
      let(:parameters) { { id: hero.id, format: :json } }
      it { expect(response).to be_success }

      it 'returns the whole hero' do
        expect(response_json).to match(hash_including(expected_attributes))
      end
    end

    context 'when requesting the templates' do
      let(:parameters) { { id: hero.id, ajax: true } }
      it { expect(response).to render_template('heros/show') }
    end
  end

  describe "GET #new" do
    before { get :new, params: { ajax: true } }
    it { expect(response).to be_success }
    it { expect(response).to render_template('heros/new') }
  end

  describe "GET #edit" do
    context 'when requesting the view' do
      before { get :edit, params: { id: hero.id, ajax: true } }
      it { expect(response).to be_success }
      it { expect(response).to render_template('heros/edit') }
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:expected_attributes) do
        valid_attributes.merge('id' => anything)
      end
      it do
        expect do
          post :create, params: { hero: valid_attributes, format: :json }
        end.to change(Hero, :count).by(1)
      end

      context 'after the request' do
        before do
          post :create, params: {hero: valid_attributes, format: :json }
        end

        it { expect(response).to be_success }

        it 'returns the whole hero' do
          expect(response_json).to match(hash_including(expected_attributes))
        end
      end
    end

    context "with invalid params" do
      it do
        expect do
          post :create, params: { hero: invalid_attributes } rescue nil
        end.not_to change(Hero, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:expected_attributes) do
        valid_attributes.merge('id' => hero.id)
      end
      it 'updates the requested hero' do
        expect do
          put :update, params: {id: hero.to_param, hero: valid_attributes, format: :json }
        end.to change { hero.tap(&:reload).name }
      end

      it 'returns the whole hero' do
        put :update, params: {id: hero.to_param, hero: valid_attributes, format: :json }
        expect(response_json).to match(hash_including(expected_attributes))
      end
    end

    context "with invalid params" do
      let(:hero) { heros(:mercy) }

      it do
        expect do
          put :update, params: {id: hero.to_param, hero: invalid_attributes, format: :json } rescue nil
        end.not_to change(Hero, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested hero" do
      expect do
        delete :destroy, params: { id: hero.id, format: :json }
      end.to change(Hero, :count).by(-1)
    end
  end
end
