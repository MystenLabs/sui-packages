module 0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardConfig has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        emission_rate: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ProtocolConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        open_staking: bool,
        reward_configs: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardConfig>,
    }

    public(friend) fun assert_allow_staking(arg0: &ProtocolConfig) {
        assert!(arg0.open_staking, 0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::errors::error_not_allow_stake());
    }

    public(friend) fun assert_current_version_invalid(arg0: &ProtocolConfig) {
        assert!(arg0.version >= 1, 0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::errors::error_invalid_protocol_version());
    }

    public(friend) fun assert_reward_info_registered(arg0: &ProtocolConfig, arg1: &0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, arg1), 0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::errors::error_not_exist_reward_config());
    }

    public fun check_is_allow_staking(arg0: &ProtocolConfig) : bool {
        arg0.open_staking
    }

    public fun get_all_reward_coin_types(arg0: &ProtocolConfig) : vector<0x1::type_name::TypeName> {
        0x2::vec_map::keys<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)
    }

    public fun get_config_emission_rate(arg0: &ProtocolConfig, arg1: &0x1::type_name::TypeName) : u64 {
        assert_reward_info_registered(arg0, arg1);
        0x2::vec_map::get<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, arg1).emission_rate
    }

    public fun get_config_open_staking(arg0: &ProtocolConfig) : bool {
        arg0.open_staking
    }

    public fun get_config_reward_end_time(arg0: &ProtocolConfig, arg1: &0x1::type_name::TypeName) : u64 {
        assert_reward_info_registered(arg0, arg1);
        0x2::vec_map::get<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, arg1).end_time
    }

    public fun get_config_reward_start_time(arg0: &ProtocolConfig, arg1: &0x1::type_name::TypeName) : u64 {
        assert_reward_info_registered(arg0, arg1);
        0x2::vec_map::get<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, arg1).start_time
    }

    public fun get_config_version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id             : 0x2::object::new(arg0),
            version        : 1,
            open_staking   : true,
            reward_configs : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardConfig>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::events::emit_init_config(0x2::object::id<AdminCap>(&v1), 0x2::object::id<ProtocolConfig>(&v0));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<ProtocolConfig>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public(friend) fun set_reward_config<T0>(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg1.reward_configs, &v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg1.reward_configs, &v0);
            v1.emission_rate = arg2;
            v1.start_time = arg3;
            v1.end_time = arg4;
        } else {
            let v2 = RewardConfig{
                id            : 0x2::object::new(arg5),
                start_time    : arg3,
                end_time      : arg4,
                emission_rate : arg2,
                coin_type     : 0x1::type_name::get<T0>(),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, RewardConfig>(&mut arg1.reward_configs, v0, v2);
        };
        0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::events::emit_update_reward_config(arg2, arg3, arg4);
    }

    public fun start_staking(arg0: &AdminCap, arg1: &mut ProtocolConfig) {
        if (arg1.open_staking) {
            return
        };
        arg1.open_staking = true;
        0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::events::emit_update_staking_status(arg1.open_staking);
    }

    public fun stop_staking(arg0: &AdminCap, arg1: &mut ProtocolConfig) {
        if (!arg1.open_staking) {
            return
        };
        arg1.open_staking = false;
        0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::events::emit_update_staking_status(arg1.open_staking);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        arg1.version = arg2;
        assert_current_version_invalid(arg1);
        0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::events::emit_update_package_version(arg2);
    }

    // decompiled from Move bytecode v6
}

