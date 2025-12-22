module 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::platform {
    struct PlatformConfig has key {
        id: 0x2::object::UID,
        owner: address,
        treasury: address,
        platform_fee_bps: u64,
        min_goal: u64,
        max_goal: u64,
        min_duration_ms: u64,
        max_duration_ms: u64,
        allowed_coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    entry fun add_allowed_coin<T0>(arg0: &mut PlatformConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_coins, 0x1::type_name::get_with_original_ids<T0>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get_with_original_ids<0x2::sui::SUI>());
        let v1 = PlatformConfig{
            id               : 0x2::object::new(arg0),
            owner            : 0x2::tx_context::sender(arg0),
            treasury         : @0x4d97a24a8de101983294c19b0a15048417ce9ec5900cb5ce7ce2a7ee4d11e50d,
            platform_fee_bps : 500,
            min_goal         : 1000000000,
            max_goal         : 1000000000000000,
            min_duration_ms  : 86400000,
            max_duration_ms  : 7776000000,
            allowed_coins    : v0,
        };
        0x2::transfer::share_object<PlatformConfig>(v1);
    }

    public fun is_coin_allowed<T0>(arg0: &PlatformConfig) : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0)
    }

    public fun max_duration_ms(arg0: &PlatformConfig) : u64 {
        arg0.max_duration_ms
    }

    public fun max_goal(arg0: &PlatformConfig) : u64 {
        arg0.max_goal
    }

    public fun min_duration_ms(arg0: &PlatformConfig) : u64 {
        arg0.min_duration_ms
    }

    public fun min_goal(arg0: &PlatformConfig) : u64 {
        arg0.min_goal
    }

    public fun owner(arg0: &PlatformConfig) : address {
        arg0.owner
    }

    public fun platform_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.platform_fee_bps
    }

    entry fun remove_allowed_coin<T0>(arg0: &mut PlatformConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_coins, &v0);
    }

    entry fun set_duration_limits(arg0: &mut PlatformConfig, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg1 < arg2, 4);
        arg0.min_duration_ms = arg1;
        arg0.max_duration_ms = arg2;
    }

    entry fun set_fee(arg0: &mut PlatformConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 <= 1000, 2);
        arg0.platform_fee_bps = arg1;
    }

    entry fun set_goal_limits(arg0: &mut PlatformConfig, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        assert!(arg1 < arg2, 3);
        arg0.min_goal = arg1;
        arg0.max_goal = arg2;
    }

    entry fun set_treasury(arg0: &mut PlatformConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.treasury = arg1;
    }

    entry fun transfer_ownership(arg0: &mut PlatformConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    public fun treasury(arg0: &PlatformConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

