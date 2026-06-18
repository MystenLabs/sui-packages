module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::router {
    fun add_point(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: address) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::router_domain());
        assert_scoreboard_match(arg1, arg2);
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::add_score(arg2, arg3, arg4, arg5);
    }

    public fun add_point_by_admin(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: address) {
        add_point(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun add_point_by_protocol(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        add_point(arg0, arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg5));
    }

    fun assert_scoreboard_match(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard) {
        assert!(*0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::get_point_cap_project_ID(arg0) == *0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::get_scoreboard_project_ID(arg1), 0);
    }

    public fun create_incentive_system(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::system::ProtocolAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::router_domain());
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::system::new_incentive_system(arg0, arg1, arg2, arg3);
    }

    public fun create_scoreboard(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::router_domain());
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::create_shared_scoreboard(arg0, arg1, arg2);
    }

    public fun set_linear_time_pause_by_admin(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: bool, arg4: &0x2::clock::Clock) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::router_domain());
        assert_scoreboard_match(arg1, arg2);
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::set_linear_time_paused(arg2, arg3, arg4);
    }

    fun set_linear_time_point(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: address) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::router_domain());
        assert_scoreboard_match(arg1, arg2);
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::set_linear_time_score(arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_linear_time_point_by_admin(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: address) {
        set_linear_time_point(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_linear_time_point_by_protocol(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        set_linear_time_point(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6));
    }

    fun subtract_point(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: address) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::router_domain());
        assert_scoreboard_match(arg1, arg2);
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::sub_score(arg2, arg3, arg4);
    }

    public fun subtract_point_by_admin(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: address) {
        subtract_point(arg0, arg1, arg2, arg3, arg4);
    }

    public fun subtract_point_by_protocol(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        subtract_point(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    fun update_linear_time_point(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: address) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::assert_domain_enabled(arg0, 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::router_domain());
        assert_scoreboard_match(arg1, arg2);
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::update_linear_time_score(arg2, arg3, arg4, arg5, arg6);
    }

    public fun update_linear_time_point_by_admin(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: address) {
        update_linear_time_point(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun update_linear_time_point_by_protocol(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        update_linear_time_point(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

