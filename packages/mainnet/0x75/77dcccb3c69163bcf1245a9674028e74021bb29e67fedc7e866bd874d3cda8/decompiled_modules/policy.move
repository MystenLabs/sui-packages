module 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PolicyRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        revoked: 0x2::vec_set::VecSet<0x2::object::ID>,
        owners: 0x2::table::Table<0x2::object::ID, address>,
        priced_tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        pricing_market_id: 0x1::option::Option<0x2::object::ID>,
        admins: 0x2::vec_set::VecSet<address>,
    }

    struct PricedTokenRegistered has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    struct PricedTokenUnregistered has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    struct PricingMarketSet has copy, drop {
        market_id: 0x2::object::ID,
        replaced_existing: bool,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    public fun add_admin(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg0.admins, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg2);
            let v0 = AdminAdded{admin: arg2};
            0x2::event::emit<AdminAdded>(v0);
        };
    }

    public(friend) fun assert_not_revoked(arg0: &PolicyRegistry, arg1: 0x2::object::ID) {
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked, &arg1), 4);
    }

    public(friend) fun assert_priced_token(arg0: &PolicyRegistry, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.priced_tokens, &arg1), 2);
    }

    public(friend) fun assert_pricing_market(arg0: &PolicyRegistry, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pricing_market_id), 7);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.pricing_market_id) == arg1, 8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = PolicyRegistry{
            id                : 0x2::object::new(arg0),
            version           : 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::version::current(),
            revoked           : 0x2::vec_set::empty<0x2::object::ID>(),
            owners            : 0x2::table::new<0x2::object::ID, address>(arg0),
            priced_tokens     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            pricing_market_id : 0x1::option::none<0x2::object::ID>(),
            admins            : v1,
        };
        0x2::transfer::share_object<PolicyRegistry>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
    }

    public(friend) fun is_admin(arg0: &PolicyRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public(friend) fun mark_revoked(arg0: &mut PolicyRegistry, arg1: 0x2::object::ID) {
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked, arg1);
        };
    }

    public fun migrate_registry(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 == 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::version::current(), 5);
        assert!(arg0.version < arg2, 5);
        arg0.version = arg2;
    }

    public(friend) fun owner_of(arg0: &PolicyRegistry, arg1: 0x2::object::ID) : address {
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg0.owners, arg1), 3);
        *0x2::table::borrow<0x2::object::ID, address>(&arg0.owners, arg1)
    }

    public(friend) fun record_owner(arg0: &mut PolicyRegistry, arg1: 0x2::object::ID, arg2: address) {
        0x2::table::add<0x2::object::ID, address>(&mut arg0.owners, arg1, arg2);
    }

    public fun register_priced_token<T0>(arg0: &mut PolicyRegistry, arg1: &AdminCap) {
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::version::assert_is_current(arg0.version);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.priced_tokens, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.priced_tokens, v0);
            let v1 = PricedTokenRegistered{token: v0};
            0x2::event::emit<PricedTokenRegistered>(v1);
        };
    }

    public fun remove_admin(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg0.admins, &arg2)) {
            assert!(0x2::vec_set::length<address>(&arg0.admins) > 1, 6);
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
            let v0 = AdminRemoved{admin: arg2};
            0x2::event::emit<AdminRemoved>(v0);
        };
    }

    public fun set_pricing_market(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: 0x2::object::ID) {
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::version::assert_is_current(arg0.version);
        arg0.pricing_market_id = 0x1::option::some<0x2::object::ID>(arg2);
        let v0 = PricingMarketSet{
            market_id         : arg2,
            replaced_existing : 0x1::option::is_some<0x2::object::ID>(&arg0.pricing_market_id),
        };
        0x2::event::emit<PricingMarketSet>(v0);
    }

    public fun unregister_priced_token<T0>(arg0: &mut PolicyRegistry, arg1: &AdminCap) {
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::version::assert_is_current(arg0.version);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.priced_tokens, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.priced_tokens, &v0);
            let v1 = PricedTokenUnregistered{token: v0};
            0x2::event::emit<PricedTokenUnregistered>(v1);
        };
    }

    public(friend) fun version_of(arg0: &PolicyRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

