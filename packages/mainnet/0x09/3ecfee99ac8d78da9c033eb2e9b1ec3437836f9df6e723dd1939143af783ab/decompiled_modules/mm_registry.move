module 0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::mm_registry {
    struct MMRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        pool_configs: 0x2::table::Table<0x2::object::ID, PoolConfig>,
        default_config: 0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::config::MMConfig,
    }

    struct PoolConfig has copy, drop, store {
        pool_id: 0x2::object::ID,
        config: 0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::config::MMConfig,
        enabled: bool,
        quote_decimals: u8,
        base_decimals: u8,
    }

    struct MMAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MM_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun configure_pool(arg0: &mut MMRegistry, arg1: &MMAdminCap, arg2: 0x2::object::ID, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg2), 3);
        let v0 = PoolConfig{
            pool_id        : arg2,
            config         : arg0.default_config,
            enabled        : true,
            quote_decimals : arg3,
            base_decimals  : arg4,
        };
        0x2::table::add<0x2::object::ID, PoolConfig>(&mut arg0.pool_configs, arg2, v0);
        0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::events::emit_pool_registered(arg2, arg0.default_config, 0x2::clock::timestamp_ms(arg5));
    }

    public fun configure_pool_with_config(arg0: &mut MMRegistry, arg1: &MMAdminCap, arg2: 0x2::object::ID, arg3: u8, arg4: u8, arg5: 0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::config::MMConfig, arg6: &0x2::clock::Clock) {
        assert!(!0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg2), 3);
        let v0 = PoolConfig{
            pool_id        : arg2,
            config         : arg5,
            enabled        : false,
            quote_decimals : arg3,
            base_decimals  : arg4,
        };
        0x2::table::add<0x2::object::ID, PoolConfig>(&mut arg0.pool_configs, arg2, v0);
        0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::events::emit_pool_registered(arg2, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public fun disable_pool(arg0: &mut MMRegistry, arg1: &MMAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg2), 2);
        0x2::table::borrow_mut<0x2::object::ID, PoolConfig>(&mut arg0.pool_configs, arg2).enabled = false;
        0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::events::emit_pool_status_changed(arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    public fun enable_pool(arg0: &mut MMRegistry, arg1: &MMAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg2), 2);
        0x2::table::borrow_mut<0x2::object::ID, PoolConfig>(&mut arg0.pool_configs, arg2).enabled = true;
        0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::events::emit_pool_status_changed(arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    public fun get_full_pool_config(arg0: &MMRegistry, arg1: 0x2::object::ID) : &PoolConfig {
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1), 2);
        0x2::table::borrow<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1)
    }

    public fun get_pool_config(arg0: &MMRegistry, arg1: 0x2::object::ID) : &0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::config::MMConfig {
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1), 2);
        &0x2::table::borrow<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1).config
    }

    public fun get_pool_decimals(arg0: &MMRegistry, arg1: 0x2::object::ID) : (u8, u8) {
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1), 2);
        let v0 = 0x2::table::borrow<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1);
        (v0.base_decimals, v0.quote_decimals)
    }

    fun init(arg0: MM_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MMRegistry{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            pool_configs   : 0x2::table::new<0x2::object::ID, PoolConfig>(arg1),
            default_config : 0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::config::default(),
        };
        let v1 = MMAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<MMRegistry>(v0);
        0x2::transfer::transfer<MMAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_pool_configured(arg0: &MMRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1)
    }

    public fun is_pool_enabled(arg0: &MMRegistry, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1)) {
            return false
        };
        0x2::table::borrow<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg1).enabled
    }

    public(friend) fun registry_id(arg0: &MMRegistry) : 0x2::object::ID {
        0x2::object::id<MMRegistry>(arg0)
    }

    public fun update_default_config(arg0: &mut MMRegistry, arg1: &MMAdminCap, arg2: 0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::config::MMConfig) {
        arg0.default_config = arg2;
    }

    public fun update_pool_config(arg0: &mut MMRegistry, arg1: &MMAdminCap, arg2: 0x2::object::ID, arg3: 0x93ecfee99ac8d78da9c033eb2e9b1ec3437836f9df6e723dd1939143af783ab::config::MMConfig, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, PoolConfig>(&arg0.pool_configs, arg2), 2);
        0x2::table::borrow_mut<0x2::object::ID, PoolConfig>(&mut arg0.pool_configs, arg2).config = arg3;
    }

    // decompiled from Move bytecode v6
}

