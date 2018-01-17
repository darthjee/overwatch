require 'spec_helper'

describe AbilitiesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Ability. As you add validations to Ability, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      'name' => 'Angelic Descent',
      'description' => 'Slow fall',
      'is_ultimate' => false
    }
  end

  let(:invalid_attributes) do
    {}
  end

  let(:expected_attributes) do
    {
      'id' => 1,
      'name' => 'Regeneration',
      'description' => 'Regenerates',
      'is_ultimate' => false
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AbilitiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:ability) { abilities(:regeneration) }
  let(:response_json) { JSON.parse(response.body) }

  describe "GET #index" do
    let(:parameters) { { format: :json } }
    before { get :index, params: parameters }

    context 'when requestin the REST api' do
      it { expect(response).to be_success }

      it 'returns all abilities' do
        expect(response_json.mapk('name')).to eq(['Regeneration'])
      end

      it 'returns all the information' do
        expect(response_json).to include(hash_including(expected_attributes))
      end
    end

    context 'when requesting the templates' do
      let(:parameters) { { ajax: true } }
      it { expect(response).to render_template('abilities/index') }
    end
  end

  describe "GET #show" do
    before { get :show, params: parameters }

    context 'when requestin the REST api' do
      let(:parameters) { { id: ability.id, format: :json } }
      it { expect(response).to be_success }

      it 'returns the whole ability' do
        expect(response_json).to match(hash_including(expected_attributes))
      end
    end

    context 'when requesting the templates' do
      let(:parameters) { { id: ability.id, ajax: true } }
      it { expect(response).to render_template('abilities/show') }
    end
  end

  describe "GET #new" do
    before { get :new, params: { ajax: true } }
    it { expect(response).to be_success }
    it { expect(response).to render_template('abilities/new') }
  end

  describe "GET #edit" do
    context 'when requesting the view' do
      before { get :edit, params: { id: ability.id, ajax: true } }
      it { expect(response).to be_success }
      it { expect(response).to render_template('abilities/edit') }
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:expected_attributes) do
        valid_attributes.merge('id' => anything)
      end
      it do
        expect do
          post :create, params: { ability: valid_attributes, format: :json }
        end.to change(Ability, :count).by(1)
      end

      context 'after the request' do
        before do
          post :create, params: {ability: valid_attributes, format: :json }
        end

        it { expect(response).to be_success }

        it 'returns the whole ability' do
          expect(response_json).to match(hash_including(expected_attributes))
        end
      end
    end

    context "with invalid params" do
      it do
        expect do
          post :create, params: { ability: invalid_attributes } rescue nil
        end.not_to change(Ability, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:expected_attributes) do
        valid_attributes.merge('id' => ability.id)
      end
      it 'updates the requested ability' do
        expect do
          put :update, params: {id: ability.to_param, ability: valid_attributes, format: :json }
        end.to change { ability.tap(&:reload).name }
      end

      it 'returns the whole ability' do
        put :update, params: {id: ability.to_param, ability: valid_attributes, format: :json }
        expect(response_json).to match(hash_including(expected_attributes))
      end
    end

    context "with invalid params" do
      let(:ability) { abilities(:regeneration) }

      it do
        expect do
          put :update, params: {id: ability.to_param, ability: invalid_attributes, format: :json } rescue nil
        end.not_to change(Ability, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested ability" do
      expect do
        delete :destroy, params: { id: ability.id, format: :json }
      end.to change(Ability, :count).by(-1)
    end
  end
end
