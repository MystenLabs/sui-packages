module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::craft_batch {
    public fun is_stackable(arg0: &0x1::string::String) : bool {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(arg0)
    }

    public fun assert_attempts(arg0: bool, arg1: u16) {
        assert!(arg1 >= 1 && arg1 <= max_attempts(arg0), 2320);
    }

    public fun assert_level(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData, arg1: u64) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::level_from_xp(arg1) >= 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::required_level(arg0), 2305);
    }

    public fun assert_output(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData, arg1: 0x2::object::ID) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::output_template(arg0) == arg1, 2323);
    }

    public fun assert_output_target(arg0: bool, arg1: u16, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: bool, arg6: bool) {
        if (!arg0) {
            assert!(arg1 == 1 && 0x1::option::is_none<0x2::object::ID>(&arg3), 2323);
            return
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            let v0 = if (0x1::option::destroy_some<0x2::object::ID>(arg3) == arg2) {
                if (!arg5) {
                    !arg6
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 2323);
            assert!(arg4 + (arg1 as u64) <= 4294967295, 2324);
        };
    }

    public fun input_count(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData, arg1: u64) : u64 {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::input_count(arg0);
        assert!(arg1 == v0, 2321);
        v0
    }

    public fun input_quantity(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData, arg1: u64, arg2: 0x2::object::ID, arg3: u16, arg4: u64) : u32 {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::ingredient_index(arg0, arg2);
        assert!(0x1::option::is_some<u64>(&v0) && 0x1::option::destroy_some<u64>(v0) == arg1, 2321);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::input_quantity(arg0, arg1) * (arg3 as u64);
        assert!(arg4 >= v1, 2322);
        (v1 as u32)
    }

    fun integer_sqrt(arg0: u64) : u64 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun job(arg0: &0x1::string::String, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData) : 0x1::string::String {
        0x1::option::destroy_with_default<0x1::string::String>(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::craft_job_of(arg0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::job(arg1))
    }

    public fun max_attempts(arg0: bool) : u16 {
        if (arg0) {
            1000
        } else {
            1
        }
    }

    public fun resolve(arg0: u64, arg1: u64, arg2: u16, arg3: u16, arg4: u16) : (u16, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = (arg2 as u64);
        while (v3 > 0) {
            let (v4, v5) = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::level_and_next_xp(arg1);
            let v6 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::craft_xp_at_level(arg0, v4);
            let v7 = if (v6 == 0 || v4 == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::max_level()) {
                v3
            } else {
                let v8 = (v5 - arg1 + v6 - 1) / v6;
                if (v8 < v3) {
                    v8
                } else {
                    v3
                }
            };
            let v9 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::craft_success_bp(v4);
            v1 = v1 + v7 * v9;
            v2 = v2 + v7 * v9 * (10000 - v9);
            let v10 = v7 * v6;
            arg1 = arg1 + v10;
            v0 = v0 + v10;
            v3 = v3 - v7;
        };
        let v11 = if ((arg3 as u64) < v1 % 10000) {
            1
        } else {
            0
        };
        let v12 = v1 / 10000 + v11;
        let v13 = if (v12 < (arg2 as u64) - v12) {
            v12
        } else {
            (arg2 as u64) - v12
        };
        let v14 = integer_sqrt(3 * v2) / 10000;
        let v15 = if (v14 < v13) {
            v14
        } else {
            v13
        };
        let v16 = if (v15 == 0) {
            0
        } else {
            (arg4 as u64) / 2 % (v15 + 1)
        };
        let v17 = if (arg4 % 2 == 0) {
            v12 - v16
        } else {
            v12 + v16
        };
        ((v17 as u16), v0)
    }

    public fun shape(arg0: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::recipe_data::RecipeData, arg1: 0x2::object::ID, arg2: &0x1::string::String, arg3: u16, arg4: u64) : (0x1::string::String, bool, u64) {
        assert_output(arg0, arg1);
        let v0 = is_stackable(arg2);
        assert_attempts(v0, arg3);
        (job(arg2, arg0), v0, input_count(arg0, arg4))
    }

    // decompiled from Move bytecode v7
}

