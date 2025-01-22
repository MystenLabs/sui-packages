module 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::config {
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

    struct RewardSnapshot has copy, drop, store {
        start_time: u64,
        end_time: u64,
        emission_rate: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ProtocolConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        open_staking: bool,
        max_staking_amount: u64,
        reward_configs: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardConfig>,
        snapshots: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<RewardSnapshot>>,
        suspicious_position_table: 0x2::table::Table<address, bool>,
        position_staked_map: 0x2::table::Table<address, u64>,
    }

    public(friend) fun add_reward_config_history(arg0: &mut ProtocolConfig, arg1: RewardSnapshot) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<RewardSnapshot>>(&arg0.snapshots, &arg1.coin_type)) {
            0x1::vector::push_back<RewardSnapshot>(0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<RewardSnapshot>>(&mut arg0.snapshots, &arg1.coin_type), arg1);
        } else {
            let v0 = 0x1::vector::empty<RewardSnapshot>();
            0x1::vector::push_back<RewardSnapshot>(&mut v0, arg1);
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<RewardSnapshot>>(&mut arg0.snapshots, arg1.coin_type, v0);
        };
    }

    public(friend) fun add_suspicious_position(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.suspicious_position_table, arg2)) {
            return
        };
        0x2::table::add<address, bool>(&mut arg1.suspicious_position_table, arg2, true);
    }

    public(friend) fun assert_allow_staking(arg0: &ProtocolConfig) {
        assert!(arg0.open_staking, 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::errors::error_not_allow_stake());
    }

    public(friend) fun assert_current_version_invalid(arg0: &ProtocolConfig) {
        assert!(arg0.version >= 1, 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::errors::error_invalid_protocol_version());
    }

    public(friend) fun assert_max_staked_amount(arg0: &ProtocolConfig, arg1: u64) {
        assert!(arg0.max_staking_amount >= arg1, 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::errors::error_max_staked_amount());
    }

    public(friend) fun assert_reward_info_registered(arg0: &ProtocolConfig, arg1: &0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, arg1), 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::errors::error_not_exist_reward_config());
    }

    public(friend) fun assert_suspicious_position(arg0: &ProtocolConfig, arg1: address) {
        assert!(!0x2::table::contains<address, bool>(&arg0.suspicious_position_table, arg1), 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::errors::error_suspicious_position());
    }

    public fun check_is_allow_staking(arg0: &ProtocolConfig) : bool {
        arg0.open_staking
    }

    public fun check_is_suspicious_position(arg0: &ProtocolConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.suspicious_position_table, arg1)
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

    public fun get_max_staking_amount(arg0: &ProtocolConfig) : u64 {
        arg0.max_staking_amount
    }

    public(friend) fun get_position_staked_amount(arg0: &ProtocolConfig, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.position_staked_map, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id                        : 0x2::object::new(arg0),
            version                   : 1,
            open_staking              : true,
            max_staking_amount        : 0,
            reward_configs            : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardConfig>(),
            snapshots                 : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<RewardSnapshot>>(),
            suspicious_position_table : 0x2::table::new<address, bool>(arg0),
            position_staked_map       : 0x2::table::new<address, u64>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::events::emit_init_config(0x2::object::id<AdminCap>(&v1), 0x2::object::id<ProtocolConfig>(&v0));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<ProtocolConfig>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public(friend) fun record_position_staked_amount(arg0: &mut ProtocolConfig, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.position_staked_map, arg1)) {
            if (arg2 == 0) {
                0x2::table::remove<address, u64>(&mut arg0.position_staked_map, arg1);
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.position_staked_map, arg1) = arg2;
            };
        } else {
            0x2::table::add<address, u64>(&mut arg0.position_staked_map, arg1, arg2);
        };
    }

    public(friend) fun remove_suspicious_position(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: address) {
        if (!0x2::table::contains<address, bool>(&arg1.suspicious_position_table, arg2)) {
            return
        };
        0x2::table::remove<address, bool>(&mut arg1.suspicious_position_table, arg2);
    }

    public fun set_max_staking_amount(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        arg1.max_staking_amount = arg2;
    }

    public(friend) fun set_reward_config<T0>(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg1.reward_configs, &v0)) {
            let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardConfig>(&arg1.reward_configs, &v0);
            let v2 = RewardSnapshot{
                start_time    : v1.start_time,
                end_time      : arg3,
                emission_rate : v1.emission_rate,
                coin_type     : v1.coin_type,
            };
            add_reward_config_history(arg1, v2);
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg1.reward_configs, &v0);
            v3.emission_rate = arg2;
            v3.start_time = arg3;
            v3.end_time = arg4;
        } else {
            let v4 = RewardConfig{
                id            : 0x2::object::new(arg5),
                start_time    : arg3,
                end_time      : arg4,
                emission_rate : arg2,
                coin_type     : 0x1::type_name::get<T0>(),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, RewardConfig>(&mut arg1.reward_configs, v0, v4);
        };
        0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::events::emit_update_reward_config(arg2, arg3, arg4);
    }

    public fun start_staking(arg0: &AdminCap, arg1: &mut ProtocolConfig) {
        if (arg1.open_staking) {
            return
        };
        arg1.open_staking = true;
        0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::events::emit_update_staking_status(arg1.open_staking);
    }

    public fun stop_staking(arg0: &AdminCap, arg1: &mut ProtocolConfig) {
        if (!arg1.open_staking) {
            return
        };
        arg1.open_staking = false;
        0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::events::emit_update_staking_status(arg1.open_staking);
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        arg1.version = arg2;
        assert_current_version_invalid(arg1);
        0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::events::emit_update_package_version(arg2);
    }

    // decompiled from Move bytecode v6
}

