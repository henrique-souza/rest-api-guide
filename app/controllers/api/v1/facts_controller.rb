# frozen_string_literal: true

module Api
  module V1
    # Facts class controller
    class FactsController < ApplicationController
      before_action :find_fact, only: %i[show update destroy]

      def index
        @facts = Fact.all
        render json: @facts
      end

      def show
        render json: @fact
      end

      def create
        @fact = Fact.new(fact_params)
        if @fact.save
          render json: @fact
        else
          render error: { error: 'Unable to create fact.' }, status: 400
        end
      end

      def update
        if @fact
          @fact.update(fact_params)
          render json: { message: 'Fact successfully updated.' }, status: 200
        else
          render json: { error: 'Unable to update fact.' }, status: 400
        end
      end

      def destroy
        if @fact
          @fact.destroy
          render json: { message: 'Fact successfully deleted.' }, status: 200
        else
          render json: { error: 'Unable to delete fact.' }, status: 400
        end
      end

      private

      def fact_params
        params.require(:fact).permit(:fact, :likes, :user_id)
      end

      def find_fact
        @fact = Fact.find(params[:id])
      end
    end
  end
end
