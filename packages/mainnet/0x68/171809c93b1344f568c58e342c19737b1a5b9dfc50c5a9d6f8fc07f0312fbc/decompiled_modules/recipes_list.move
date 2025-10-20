module 0x68171809c93b1344f568c58e342c19737b1a5b9dfc50c5a9d6f8fc07f0312fbc::recipes_list {
    struct Recipe has drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_ref: 0x1::string::String,
    }

    struct RecipeList has store, key {
        id: 0x2::object::UID,
        recipes: vector<Recipe>,
    }

    public fun add_recipe(arg0: &mut RecipeList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = Recipe{
            name        : arg1,
            description : arg2,
            image_ref   : arg3,
        };
        0x1::vector::push_back<Recipe>(&mut arg0.recipes, v0);
    }

    public fun create_list(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecipeList{
            id      : 0x2::object::new(arg0),
            recipes : 0x1::vector::empty<Recipe>(),
        };
        0x2::transfer::transfer<RecipeList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun remove_recipe(arg0: &mut RecipeList, arg1: u64) {
        0x1::vector::remove<Recipe>(&mut arg0.recipes, arg1);
    }

    // decompiled from Move bytecode v6
}

