module 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::minimum_points_rules {
    struct MinimumPointsRule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        min_amounts: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>,
    }

    public fun set_config<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, MinimumPointsRule>(arg0)) {
            let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, arg3, arg4);
            let v1 = 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>();
            0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut v1, arg2, v0);
            let v2 = Config{min_amounts: v1};
            let v3 = MinimumPointsRule{dummy_field: false};
            0x2::token::add_rule_config<T0, MinimumPointsRule, Config>(v3, arg0, arg1, v2, arg5);
        } else {
            let v4 = MinimumPointsRule{dummy_field: false};
            let v5 = 0x2::token::rule_config_mut<T0, MinimumPointsRule, Config>(v4, arg0, arg1);
            if (!0x2::vec_map::contains<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&v5.min_amounts, &arg2)) {
                let v6 = 0x2::vec_map::empty<0x1::string::String, u64>();
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v6, arg3, arg4);
                0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut v5.min_amounts, arg2, v6);
            } else if (!0x2::vec_map::contains<0x1::string::String, u64>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&v5.min_amounts, &arg2), &arg3)) {
                0x2::vec_map::insert<0x1::string::String, u64>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut v5.min_amounts, &arg2), arg3, arg4);
            } else {
                *0x2::vec_map::get_mut<0x1::string::String, u64>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&mut v5.min_amounts, &arg2), &arg3) = arg4;
            };
        };
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management::PointsSpentActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management::get_reason<T0>(arg1);
        let v1 = 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management::get_action<T0>(arg1);
        let v2 = MinimumPointsRule{dummy_field: false};
        assert!(0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management::get_amount<T0>(arg1) >= *0x2::vec_map::get<0x1::string::String, u64>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&0x2::token::rule_config<T0, MinimumPointsRule, Config>(v2, arg0).min_amounts, &v1), &v0), 1);
        let v3 = MinimumPointsRule{dummy_field: false};
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management::add_approval<T0, MinimumPointsRule>(v3, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

