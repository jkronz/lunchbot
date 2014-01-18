class CreateSlackConfigs < ActiveRecord::Migration
  def change
    create_table :slack_configs do |t|
      t.string :token

      t.timestamps
    end
  end
end
