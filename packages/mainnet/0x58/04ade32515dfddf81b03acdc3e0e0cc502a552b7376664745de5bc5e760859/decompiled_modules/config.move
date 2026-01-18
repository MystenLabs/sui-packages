module 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::config {
    struct ConfigAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        current_version: u64,
        min_version: u64,
        global_enabled: bool,
        features_enabled: vector<bool>,
        last_updated: u64,
    }

    struct ConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        creator: address,
    }

    struct VersionUpdated has copy, drop {
        old_min_version: u64,
        new_min_version: u64,
        current_version: u64,
        updated_by: address,
    }

    struct FeatureToggled has copy, drop {
        feature_index: u8,
        enabled: bool,
        updated_by: address,
    }

    struct GlobalToggled has copy, drop {
        enabled: bool,
        updated_by: address,
    }

    public entry fun admin_bump_current_version(arg0: &mut GlobalConfig, arg1: &ConfigAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > arg0.current_version, 5);
        arg0.current_version = arg2;
        arg0.last_updated = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = VersionUpdated{
            old_min_version : arg0.min_version,
            new_min_version : arg0.min_version,
            current_version : arg2,
            updated_by      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<VersionUpdated>(v0);
    }

    public entry fun admin_set_min_version(arg0: &mut GlobalConfig, arg1: &ConfigAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg0.current_version, 5);
        arg0.min_version = arg2;
        arg0.last_updated = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = VersionUpdated{
            old_min_version : arg0.min_version,
            new_min_version : arg2,
            current_version : arg0.current_version,
            updated_by      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<VersionUpdated>(v0);
    }

    public entry fun admin_toggle_feature(arg0: &mut GlobalConfig, arg1: &ConfigAdminCap, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.features_enabled;
        let v1 = (arg2 as u64);
        while (0x1::vector::length<bool>(v0) <= v1) {
            0x1::vector::push_back<bool>(v0, true);
        };
        *0x1::vector::borrow_mut<bool>(v0, v1) = arg3;
        arg0.last_updated = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = FeatureToggled{
            feature_index : arg2,
            enabled       : arg3,
            updated_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeatureToggled>(v2);
    }

    public entry fun admin_toggle_global(arg0: &mut GlobalConfig, arg1: &ConfigAdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.global_enabled = arg2;
        arg0.last_updated = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = GlobalToggled{
            enabled    : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<GlobalToggled>(v0);
    }

    public fun assert_feature_enabled(arg0: &GlobalConfig, arg1: u8) {
        assert!(arg0.global_enabled, 2);
        let v0 = &arg0.features_enabled;
        if ((arg1 as u64) < 0x1::vector::length<bool>(v0)) {
            assert!(*0x1::vector::borrow<bool>(v0, (arg1 as u64)), 2);
        };
    }

    public fun assert_version(arg0: &GlobalConfig, arg1: u64) {
        assert!(arg0.min_version <= arg1, 1);
        assert!(arg0.global_enabled, 2);
    }

    public fun assert_version_and_feature(arg0: &GlobalConfig, arg1: u64, arg2: u8) {
        assert_version(arg0, arg1);
        assert_feature_enabled(arg0, arg2);
    }

    public entry fun create_config(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<GlobalConfig>(arg0), 3);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ConfigAdminCap{id: 0x2::object::new(arg1)};
        let v2 = GlobalConfig{
            id               : 0x2::object::new(arg1),
            current_version  : 11,
            min_version      : 11,
            global_enabled   : true,
            features_enabled : vector[true, true, true, true, true, true],
            last_updated     : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        let v3 = ConfigCreated{
            config_id    : 0x2::object::id<GlobalConfig>(&v2),
            admin_cap_id : 0x2::object::id<ConfigAdminCap>(&v1),
            creator      : v0,
        };
        0x2::event::emit<ConfigCreated>(v3);
        0x2::transfer::share_object<GlobalConfig>(v2);
        0x2::transfer::transfer<ConfigAdminCap>(v1, v0);
    }

    public fun feature_coin_flip() : u8 {
        5
    }

    public fun feature_harvest() : u8 {
        0
    }

    public fun feature_hatch() : u8 {
        1
    }

    public fun feature_revive() : u8 {
        4
    }

    public fun feature_stake() : u8 {
        2
    }

    public fun feature_upgrade_nest() : u8 {
        3
    }

    public fun get_last_updated(arg0: &GlobalConfig) : u64 {
        arg0.last_updated
    }

    public fun get_version_info(arg0: &GlobalConfig) : (u64, u64) {
        (arg0.current_version, arg0.min_version)
    }

    public fun is_feature_enabled(arg0: &GlobalConfig, arg1: u8) : bool {
        if (!arg0.global_enabled) {
            return false
        };
        let v0 = &arg0.features_enabled;
        let v1 = (arg1 as u64);
        if (v1 >= 0x1::vector::length<bool>(v0)) {
            return true
        };
        *0x1::vector::borrow<bool>(v0, v1)
    }

    public fun is_global_enabled(arg0: &GlobalConfig) : bool {
        arg0.global_enabled
    }

    public fun is_version_allowed(arg0: &GlobalConfig, arg1: u64) : bool {
        arg0.global_enabled && arg0.min_version <= arg1
    }

    // decompiled from Move bytecode v6
}

