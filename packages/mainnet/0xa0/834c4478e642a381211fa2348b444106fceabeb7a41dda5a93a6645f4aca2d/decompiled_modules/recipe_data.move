module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data {
    struct Ingredient has copy, drop, store {
        template: 0x2::object::ID,
        quantity: u64,
    }

    struct RecipeData has copy, drop, store {
        inputs: vector<Ingredient>,
        output_template: 0x2::object::ID,
        job: 0x1::string::String,
        required_level: u64,
    }

    public fun ingredient_index(arg0: &RecipeData, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Ingredient>(&arg0.inputs)) {
            if (0x1::vector::borrow<Ingredient>(&arg0.inputs, v0).template == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun input_count(arg0: &RecipeData) : u64 {
        0x1::vector::length<Ingredient>(&arg0.inputs)
    }

    public fun input_quantity(arg0: &RecipeData, arg1: u64) : u64 {
        0x1::vector::borrow<Ingredient>(&arg0.inputs, arg1).quantity
    }

    public fun job(arg0: &RecipeData) : 0x1::string::String {
        arg0.job
    }

    public fun new(arg0: 0x2::object::ID, arg1: vector<0x2::object::ID>, arg2: vector<u64>, arg3: 0x1::string::String) : RecipeData {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2306);
        assert!(v0 > 0, 2307);
        assert!(v0 <= 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::max_craft_ingredients(), 2310);
        let v1 = 0x1::vector::empty<Ingredient>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v2);
            assert!(v3 >= 1, 2308);
            let v4 = 0;
            while (v4 < v2) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(&arg1, v4) != *0x1::vector::borrow<0x2::object::ID>(&arg1, v2), 2311);
                v4 = v4 + 1;
            };
            let v5 = Ingredient{
                template : *0x1::vector::borrow<0x2::object::ID>(&arg1, v2),
                quantity : v3,
            };
            0x1::vector::push_back<Ingredient>(&mut v1, v5);
            v2 = v2 + 1;
        };
        RecipeData{
            inputs          : v1,
            output_template : arg0,
            job             : arg3,
            required_level  : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::craft_required_level(v0),
        }
    }

    public fun output_template(arg0: &RecipeData) : 0x2::object::ID {
        arg0.output_template
    }

    public fun required_level(arg0: &RecipeData) : u64 {
        arg0.required_level
    }

    // decompiled from Move bytecode v7
}

