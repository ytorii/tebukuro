# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations API', type: :request do
  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event) }
  let(:participant) { build_stubbed(:participant, user: user, event: event) }

  describe 'POST /events/:id/registrations' do
    let(:id) { event.id }

    before do
      sign_in_with(user)
    end

    context 'success' do
      before do
        allow_any_instance_of(Participant).to receive(:save).and_return(true)
      end

      it { is_expected.to eq 200 }
    end

    context 'failure' do
      before do
        allow(participant).to receive(:save).and_return(false)
      end

      it { is_expected.to eq 422 }
    end
  end

  describe 'DELETE /events/:id/registrations' do
    let(:id) { event.id }

    before do
      allow(Participant).to receive(:find_by).and_return(participant)
      sign_in_with(user)
    end

    context 'success' do
      before do
        allow(participant).to receive(:destroy).and_return(true)
      end

      it { is_expected.to eq 200 }
    end

    context 'failure' do
      before do
        allow(participant).to receive(:destroy).and_return(false)
      end

      it { is_expected.to eq 422 }
    end
  end
end