module 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::policy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PolicyRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        revoked: 0x2::table::Table<0x2::object::ID, bool>,
        owners: 0x2::table::Table<0x2::object::ID, address>,
        priced_feeds: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u8>>,
        max_price_age_seconds: u64,
        admins: 0x2::vec_set::VecSet<address>,
    }

    struct PricedTokenRegistered has copy, drop {
        token: 0x1::type_name::TypeName,
        feed_id: vector<u8>,
        replaced_existing: bool,
    }

    struct PricedTokenUnregistered has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    struct MaxPriceAgeSet has copy, drop {
        seconds: u64,
        previous: u64,
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
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked, arg1), 4);
    }

    public(friend) fun assert_price_feed(arg0: &PolicyRegistry, arg1: 0x1::type_name::TypeName, arg2: &vector<u8>) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.priced_feeds, &arg1), 2);
        assert!(0x2::vec_map::get<0x1::type_name::TypeName, vector<u8>>(&arg0.priced_feeds, &arg1) == arg2, 9);
    }

    public(friend) fun assert_priced_token(arg0: &PolicyRegistry, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.priced_feeds, &arg1), 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = PolicyRegistry{
            id                    : 0x2::object::new(arg0),
            version               : 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::current(),
            revoked               : 0x2::table::new<0x2::object::ID, bool>(arg0),
            owners                : 0x2::table::new<0x2::object::ID, address>(arg0),
            priced_feeds          : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u8>>(),
            max_price_age_seconds : 60,
            admins                : v1,
        };
        0x2::transfer::share_object<PolicyRegistry>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, v0);
    }

    public(friend) fun is_admin(arg0: &PolicyRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public(friend) fun is_priced_token(arg0: &PolicyRegistry, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.priced_feeds, &arg1)
    }

    public(friend) fun mark_revoked(arg0: &mut PolicyRegistry, arg1: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked, arg1)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked, arg1, true);
        };
    }

    public(friend) fun max_price_age_seconds(arg0: &PolicyRegistry) : u64 {
        arg0.max_price_age_seconds
    }

    public fun migrate_registry(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 == 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::current(), 5);
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

    public fun register_priced_token<T0>(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: vector<u8>) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 10);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.priced_feeds, &v0);
        if (v1) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u8>>(&mut arg0.priced_feeds, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<u8>>(&mut arg0.priced_feeds, v0, arg2);
        let v4 = PricedTokenRegistered{
            token             : v0,
            feed_id           : arg2,
            replaced_existing : v1,
        };
        0x2::event::emit<PricedTokenRegistered>(v4);
    }

    public fun remove_admin(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg0.admins, &arg2)) {
            assert!(0x2::vec_set::length<address>(&arg0.admins) > 1, 6);
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg2);
            let v0 = AdminRemoved{admin: arg2};
            0x2::event::emit<AdminRemoved>(v0);
        };
    }

    public fun set_max_price_age(arg0: &mut PolicyRegistry, arg1: &AdminCap, arg2: u64) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        assert!(arg2 > 0, 11);
        arg0.max_price_age_seconds = arg2;
        let v0 = MaxPriceAgeSet{
            seconds  : arg2,
            previous : arg0.max_price_age_seconds,
        };
        0x2::event::emit<MaxPriceAgeSet>(v0);
    }

    public fun unregister_priced_token<T0>(arg0: &mut PolicyRegistry, arg1: &AdminCap) {
        0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version::assert_is_current(arg0.version);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.priced_feeds, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u8>>(&mut arg0.priced_feeds, &v0);
            let v3 = PricedTokenUnregistered{token: v0};
            0x2::event::emit<PricedTokenUnregistered>(v3);
        };
    }

    public(friend) fun version_of(arg0: &PolicyRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

