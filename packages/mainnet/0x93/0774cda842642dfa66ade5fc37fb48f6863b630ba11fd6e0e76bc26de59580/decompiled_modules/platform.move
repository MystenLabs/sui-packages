module 0x930774cda842642dfa66ade5fc37fb48f6863b630ba11fd6e0e76bc26de59580::platform {
    struct Platform has store, key {
        id: 0x2::object::UID,
        platform_fee_bps: u16,
        balances: 0x2::bag::Bag,
    }

    struct PlatformAdminCapability has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun are_creator_bps_valid(arg0: u16, arg1: &Platform) : bool {
        10000 - arg0 - get_platform_fee_bps(arg1) > 0
    }

    public(friend) fun deposit_coin<T0>(arg0: &mut Platform, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::get_address(&v0));
        if (0x2::bag::contains<0x1::string::String>(&arg0.balances, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public(friend) fun get_platform_fee_bps(arg0: &Platform) : u16 {
        arg0.platform_fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformAdminCapability{id: 0x2::object::new(arg0)};
        let v1 = Platform{
            id               : 0x2::object::new(arg0),
            platform_fee_bps : 5000,
            balances         : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_transfer<PlatformAdminCapability>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Platform>(v1);
    }

    public fun update_platform_fee_bps(arg0: &PlatformAdminCapability, arg1: &mut Platform, arg2: u16) {
        arg1.platform_fee_bps = arg2;
    }

    public fun withdraw_coin<T0>(arg0: &PlatformAdminCapability, arg1: &mut Platform, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::string::from_ascii(0x1::type_name::get_address(&v0));
        assert!(0x2::bag::contains<0x1::string::String>(&arg1.balances, v1), 0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.balances, v1)), arg2)
    }

    // decompiled from Move bytecode v6
}

