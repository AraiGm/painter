class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :name
      t.binary :data
      t.string :type

      t.timestamps
    end
  end
end
