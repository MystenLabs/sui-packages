module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::recipe_rows {
    struct RecipeKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct Recipe has key {
        id: 0x2::object::UID,
        output_type: 0x1::string::String,
        data: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData,
        active: bool,
    }

    struct RecipeCreated has copy, drop {
        recipe: 0x2::object::ID,
        output_template: 0x2::object::ID,
        input_count: u64,
        job: 0x1::string::String,
        required_level: u64,
    }

    public fun active_data(arg0: &Recipe) : &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData {
        assert!(arg0.active, 2306);
        &arg0.data
    }

    public fun add_recipe(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        let v0 = RecipeKey{pos0: arg2};
        let v1 = Recipe{
            id          : 0x2::derived_object::claim<RecipeKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg7), v0),
            output_type : arg2,
            data        : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::new(arg3, arg4, arg5, arg6),
            active      : true,
        };
        let v2 = RecipeCreated{
            recipe          : 0x2::object::uid_to_inner(&v1.id),
            output_template : arg3,
            input_count     : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::input_count(&v1.data),
            job             : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::job(&v1.data),
            required_level  : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::required_level(&v1.data),
        };
        0x2::event::emit<RecipeCreated>(v2);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"recipes"), arg2, arg7);
        0x2::transfer::share_object<Recipe>(v1);
    }

    public fun data(arg0: &Recipe) : &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData {
        &arg0.data
    }

    public fun is_active(arg0: &Recipe) : bool {
        arg0.active
    }

    public fun overwrite_recipe(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut Recipe, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        arg2.data = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::new(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::output_template(&arg2.data), arg3, arg4, arg5);
        arg2.active = true;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"recipes"), arg2.output_type, arg6);
    }

    public fun retire_recipe(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut Recipe, arg3: &0x2::tx_context::TxContext) {
        arg2.active = false;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"recipes"), arg2.output_type, arg3);
    }

    // decompiled from Move bytecode v7
}

