module 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PackageCallerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReferralKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PackageWhitestKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolApp has store, key {
        id: 0x2::object::UID,
        version: u64,
        markets: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public(friend) fun add_market<T0>(arg0: &mut ProtocolApp, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_already_exists());
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.markets, v0, arg1);
    }

    public(friend) fun burn_cap(arg0: PackageCallerCap) {
        let PackageCallerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : (AdminCap, ProtocolApp) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ProtocolApp{
            id      : 0x2::object::new(arg0),
            version : 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::current_version::current_version(),
            markets : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        let v2 = ReferralKey{dummy_field: false};
        0x2::dynamic_field::add<ReferralKey, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::referral::Referral>(&mut v1.id, v2, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::referral::default(arg0));
        let v3 = PackageWhitestKey{dummy_field: false};
        0x2::dynamic_field::add<PackageWhitestKey, 0x2::vec_map::VecMap<0x2::object::ID, u32>>(&mut v1.id, v3, 0x2::vec_map::empty<0x2::object::ID, u32>());
        (v0, v1)
    }

    public fun ensure_has_permission(arg0: &ProtocolApp, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = PackageWhitestKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PackageWhitestKey, 0x2::vec_map::VecMap<0x2::object::ID, u32>>(&arg0.id, v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, u32>(v1, &arg1), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::caller_not_whitelisted());
        assert!(*0x2::vec_map::get<0x2::object::ID, u32>(v1, &arg1) & 1 << arg2 != 0, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::caller_has_no_permission());
    }

    public(friend) fun get_market_config<T0>(arg0: &ProtocolApp, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>) : &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::MarketConfiguration {
        validate_market<T0>(arg0, arg1);
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::market_config<T0>(arg1)
    }

    public(friend) fun get_market_id<T0>(arg0: &ProtocolApp) : &0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_not_found());
        0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0)
    }

    public(friend) fun get_version(arg0: &ProtocolApp) : u64 {
        arg0.version
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        let (v0, v1) = create(arg1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<ProtocolApp>(v1);
    }

    public(friend) fun is_market_registered<T0>(arg0: &ProtocolApp) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, 0x1::type_name::get<T0>())
    }

    public(friend) fun mint_cap(arg0: &mut 0x2::tx_context::TxContext) : PackageCallerCap {
        PackageCallerCap{id: 0x2::object::new(arg0)}
    }

    public fun permissions(arg0: &ProtocolApp, arg1: &PackageCallerCap) : u32 {
        let v0 = PackageWhitestKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PackageWhitestKey, 0x2::vec_map::VecMap<0x2::object::ID, u32>>(&arg0.id, v0);
        let v2 = 0x2::object::id<PackageCallerCap>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, u32>(v1, &v2), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::caller_not_whitelisted());
        *0x2::vec_map::get<0x2::object::ID, u32>(v1, &v2)
    }

    public(friend) fun referral(arg0: &ProtocolApp) : &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::referral::Referral {
        let v0 = ReferralKey{dummy_field: false};
        0x2::dynamic_field::borrow<ReferralKey, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::referral::Referral>(&arg0.id, v0)
    }

    public(friend) fun referral_mut(arg0: &mut ProtocolApp) : &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::referral::Referral {
        let v0 = ReferralKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ReferralKey, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::referral::Referral>(&mut arg0.id, v0)
    }

    public(friend) fun validate_market<T0>(arg0: &ProtocolApp, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::market_not_found());
        let v1 = 0x2::object::id<0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>>(arg1);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0) == &v1, 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::error::invalid_market());
    }

    public(friend) fun whitelist_mut(arg0: &mut ProtocolApp) : &mut 0x2::vec_map::VecMap<0x2::object::ID, u32> {
        let v0 = PackageWhitestKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PackageWhitestKey, 0x2::vec_map::VecMap<0x2::object::ID, u32>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

