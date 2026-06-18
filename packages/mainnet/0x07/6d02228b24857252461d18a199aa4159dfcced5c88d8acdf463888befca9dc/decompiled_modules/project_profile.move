module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_profile {
    struct ProjectProfile has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        token_point_scale: 0x1::option::Option<u64>,
        coin_point_ratio: 0x1::option::Option<u64>,
    }

    public fun airdrop_enabled(arg0: &ProjectProfile) : bool {
        0x1::option::is_some<u64>(&arg0.coin_point_ratio)
    }

    public(friend) fun assert_valid_token_point_scale(arg0: u64) {
        assert!(arg0 > 0, 0);
    }

    public fun coin_point_ratio(arg0: &ProjectProfile) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.coin_point_ratio), 3);
        *0x1::option::borrow<u64>(&arg0.coin_point_ratio)
    }

    public fun create_project_profile(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::system_domain());
        validate_token_point_scale(&arg2);
        validate_coin_point_ratio(&arg3);
        let v0 = ProjectProfile{
            id                : 0x2::object::new(arg4),
            project_id        : 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::get_project_cap_ID(arg1),
            token_point_scale : arg2,
            coin_point_ratio  : arg3,
        };
        let (v1, v2) = option_value_or_zero(&v0.token_point_scale);
        let (v3, v4) = option_value_or_zero(&v0.coin_point_ratio);
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::event::emit_project_profile_created(0x2::object::id<ProjectProfile>(&v0), v0.project_id, v1, v2, v3, v4);
        0x2::transfer::share_object<ProjectProfile>(v0);
    }

    fun option_value_or_zero(arg0: &0x1::option::Option<u64>) : (bool, u64) {
        if (0x1::option::is_some<u64>(arg0)) {
            (true, *0x1::option::borrow<u64>(arg0))
        } else {
            (false, 0)
        }
    }

    public fun profile_id(arg0: &ProjectProfile) : 0x2::object::ID {
        0x2::object::id<ProjectProfile>(arg0)
    }

    public fun project_id(arg0: &ProjectProfile) : 0x2::object::ID {
        arg0.project_id
    }

    public fun token_point_scale(arg0: &ProjectProfile) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.token_point_scale), 2);
        *0x1::option::borrow<u64>(&arg0.token_point_scale)
    }

    public fun tokenized_point_enabled(arg0: &ProjectProfile) : bool {
        0x1::option::is_some<u64>(&arg0.token_point_scale)
    }

    fun validate_coin_point_ratio(arg0: &0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg0)) {
            assert!(*0x1::option::borrow<u64>(arg0) > 0, 1);
        };
    }

    fun validate_token_point_scale(arg0: &0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg0)) {
            assert_valid_token_point_scale(*0x1::option::borrow<u64>(arg0));
        };
    }

    // decompiled from Move bytecode v7
}

