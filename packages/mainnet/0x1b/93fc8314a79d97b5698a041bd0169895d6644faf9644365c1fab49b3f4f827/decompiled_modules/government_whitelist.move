module 0x1b93fc8314a79d97b5698a041bd0169895d6644faf9644365c1fab49b3f4f827::government_whitelist {
    struct GovWhitelist has key {
        id: 0x2::object::UID,
        government_addresses: 0x2::table::Table<address, bool>,
        registered_users: 0x2::table::Table<address, bool>,
    }

    struct GovCap has key {
        id: 0x2::object::UID,
        whitelist_id: 0x2::object::ID,
    }

    struct GovernmentAddressAdded has copy, drop {
        whitelist_id: 0x2::object::ID,
        government_address: address,
    }

    struct UserRegistered has copy, drop {
        whitelist_id: 0x2::object::ID,
        user_address: address,
    }

    struct GovernmentAddressRemoved has copy, drop {
        whitelist_id: 0x2::object::ID,
        government_address: address,
    }

    public fun add_government_address(arg0: &mut GovWhitelist, arg1: &GovCap, arg2: address) {
        assert!(arg1.whitelist_id == 0x2::object::id<GovWhitelist>(arg0), 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.government_addresses, arg2), 3);
        0x2::table::add<address, bool>(&mut arg0.government_addresses, arg2, true);
        let v0 = GovernmentAddressAdded{
            whitelist_id       : 0x2::object::id<GovWhitelist>(arg0),
            government_address : arg2,
        };
        0x2::event::emit<GovernmentAddressAdded>(v0);
    }

    public fun can_access_document(arg0: &GovWhitelist, arg1: address, arg2: vector<u8>) : bool {
        check_policy(arg1, arg2, arg0)
    }

    fun check_policy(arg0: address, arg1: vector<u8>, arg2: &GovWhitelist) : bool {
        let v0 = 0x2::object::uid_to_bytes(&arg2.id);
        let v1 = 0;
        if (0x1::vector::length<u8>(&v0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) != *0x1::vector::borrow<u8>(&arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        if (0x2::table::contains<address, bool>(&arg2.government_addresses, arg0)) {
            return true
        };
        if (0x2::table::contains<address, bool>(&arg2.registered_users, arg0)) {
            return true
        };
        false
    }

    public fun create_government_whitelist(arg0: &mut 0x2::tx_context::TxContext) : (GovCap, GovWhitelist) {
        let v0 = GovWhitelist{
            id                   : 0x2::object::new(arg0),
            government_addresses : 0x2::table::new<address, bool>(arg0),
            registered_users     : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = GovCap{
            id           : 0x2::object::new(arg0),
            whitelist_id : 0x2::object::id<GovWhitelist>(&v0),
        };
        (v1, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovWhitelist{
            id                   : 0x2::object::new(arg0),
            government_addresses : 0x2::table::new<address, bool>(arg0),
            registered_users     : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = GovCap{
            id           : 0x2::object::new(arg0),
            whitelist_id : 0x2::object::id<GovWhitelist>(&v0),
        };
        0x2::transfer::share_object<GovWhitelist>(v0);
        0x2::transfer::transfer<GovCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_government_address(arg0: &GovWhitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.government_addresses, arg1)
    }

    public fun is_registered_user(arg0: &GovWhitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.registered_users, arg1)
    }

    entry fun register_user(arg0: &mut GovWhitelist, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, bool>(&arg0.registered_users, v0)) {
            0x2::table::add<address, bool>(&mut arg0.registered_users, v0, true);
            let v1 = UserRegistered{
                whitelist_id : 0x2::object::id<GovWhitelist>(arg0),
                user_address : v0,
            };
            0x2::event::emit<UserRegistered>(v1);
        };
    }

    entry fun register_user_sponsored(arg0: &mut GovWhitelist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, bool>(&arg0.registered_users, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.registered_users, arg1, true);
            let v0 = UserRegistered{
                whitelist_id : 0x2::object::id<GovWhitelist>(arg0),
                user_address : arg1,
            };
            0x2::event::emit<UserRegistered>(v0);
        };
    }

    public fun remove_government_address(arg0: &mut GovWhitelist, arg1: &GovCap, arg2: address) {
        assert!(arg1.whitelist_id == 0x2::object::id<GovWhitelist>(arg0), 2);
        assert!(0x2::table::contains<address, bool>(&arg0.government_addresses, arg2), 4);
        0x2::table::remove<address, bool>(&mut arg0.government_addresses, arg2);
        let v0 = GovernmentAddressRemoved{
            whitelist_id       : 0x2::object::id<GovWhitelist>(arg0),
            government_address : arg2,
        };
        0x2::event::emit<GovernmentAddressRemoved>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &GovWhitelist, arg2: &0x2::tx_context::TxContext) {
        assert!(check_policy(0x2::tx_context::sender(arg2), arg0, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

