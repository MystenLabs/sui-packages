module 0xa214483656e0be885f46dcaaf86cbc6822501a07e60062f16ca4229f5b113a13::whitelist {
    struct Whitelist has key {
        id: 0x2::object::UID,
        whitelist_entities: 0x2::table::Table<address, bool>,
        registered_users: 0x2::table::Table<address, bool>,
        version: u64,
        capability_id: 0x2::object::ID,
    }

    struct WhitelistCap has store, key {
        id: 0x2::object::UID,
    }

    struct WHITELIST has drop {
        dummy_field: bool,
    }

    struct WhitelistEntityAdded has copy, drop {
        whitelist_id: 0x2::object::ID,
        entity_address: address,
    }

    struct UserRegistered has copy, drop {
        whitelist_id: 0x2::object::ID,
        user_address: address,
    }

    struct WhitelistEntityRemoved has copy, drop {
        whitelist_id: 0x2::object::ID,
        entity_address: address,
    }

    struct WhitelistUpgraded has copy, drop {
        whitelist_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    public fun add_whitelist_entity(arg0: &mut Whitelist, arg1: &WhitelistCap, arg2: address) {
        assert_is_valid_for_whitelist(arg1, arg0);
        assert!(!0x2::table::contains<address, bool>(&arg0.whitelist_entities, arg2), 3);
        0x2::table::add<address, bool>(&mut arg0.whitelist_entities, arg2, true);
        let v0 = WhitelistEntityAdded{
            whitelist_id   : 0x2::object::id<Whitelist>(arg0),
            entity_address : arg2,
        };
        0x2::event::emit<WhitelistEntityAdded>(v0);
    }

    fun assert_is_valid_for_whitelist(arg0: &WhitelistCap, arg1: &Whitelist) {
        assert!(0x2::object::id<WhitelistCap>(arg0) == arg1.capability_id, 2);
    }

    public fun can_access_document(arg0: &Whitelist, arg1: address, arg2: vector<u8>) : bool {
        check_policy(arg1, arg2, arg0)
    }

    public fun capability_id(arg0: &Whitelist) : 0x2::object::ID {
        arg0.capability_id
    }

    fun check_policy(arg0: address, arg1: vector<u8>, arg2: &Whitelist) : bool {
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
        if (0x2::table::contains<address, bool>(&arg2.whitelist_entities, arg0)) {
            return true
        };
        if (0x2::table::contains<address, bool>(&arg2.registered_users, arg0)) {
            return true
        };
        false
    }

    public fun create_whitelist(arg0: &mut 0x2::tx_context::TxContext) : (WhitelistCap, Whitelist) {
        let v0 = WhitelistCap{id: 0x2::object::new(arg0)};
        let v1 = Whitelist{
            id                 : 0x2::object::new(arg0),
            whitelist_entities : 0x2::table::new<address, bool>(arg0),
            registered_users   : 0x2::table::new<address, bool>(arg0),
            version            : 1,
            capability_id      : 0x2::object::id<WhitelistCap>(&v0),
        };
        (v0, v1)
    }

    fun init(arg0: WHITELIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_cap(arg0, arg1);
        let v1 = Whitelist{
            id                 : 0x2::object::new(arg1),
            whitelist_entities : 0x2::table::new<address, bool>(arg1),
            registered_users   : 0x2::table::new<address, bool>(arg1),
            version            : 1,
            capability_id      : 0x2::object::id<WhitelistCap>(&v0),
        };
        0x2::transfer::share_object<Whitelist>(v1);
        0x2::transfer::public_transfer<WhitelistCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_registered_user(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.registered_users, arg1)
    }

    public fun is_whitelist_entity(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist_entities, arg1)
    }

    entry fun migrate(arg0: &mut Whitelist, arg1: &WhitelistCap) {
        assert!(0x2::object::id<WhitelistCap>(arg1) == arg0.capability_id, 2);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
        let v0 = WhitelistUpgraded{
            whitelist_id : 0x2::object::id<Whitelist>(arg0),
            old_version  : arg0.version,
            new_version  : 1,
        };
        0x2::event::emit<WhitelistUpgraded>(v0);
    }

    public fun new_cap(arg0: WHITELIST, arg1: &mut 0x2::tx_context::TxContext) : WhitelistCap {
        WhitelistCap{id: 0x2::object::new(arg1)}
    }

    entry fun register_user(arg0: &mut Whitelist, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, bool>(&arg0.registered_users, v0)) {
            0x2::table::add<address, bool>(&mut arg0.registered_users, v0, true);
            let v1 = UserRegistered{
                whitelist_id : 0x2::object::id<Whitelist>(arg0),
                user_address : v0,
            };
            0x2::event::emit<UserRegistered>(v1);
        };
    }

    entry fun register_user_sponsored(arg0: &mut Whitelist, arg1: address, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, bool>(&arg0.registered_users, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.registered_users, arg1, true);
            let v0 = UserRegistered{
                whitelist_id : 0x2::object::id<Whitelist>(arg0),
                user_address : arg1,
            };
            0x2::event::emit<UserRegistered>(v0);
        };
    }

    public fun remove_whitelist_entity(arg0: &mut Whitelist, arg1: &WhitelistCap, arg2: address) {
        assert_is_valid_for_whitelist(arg1, arg0);
        assert!(0x2::table::contains<address, bool>(&arg0.whitelist_entities, arg2), 4);
        0x2::table::remove<address, bool>(&mut arg0.whitelist_entities, arg2);
        let v0 = WhitelistEntityRemoved{
            whitelist_id   : 0x2::object::id<Whitelist>(arg0),
            entity_address : arg2,
        };
        0x2::event::emit<WhitelistEntityRemoved>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Whitelist, arg2: &0x2::tx_context::TxContext) {
        assert!(check_policy(0x2::tx_context::sender(arg2), arg0, arg1), 1);
    }

    public fun version(arg0: &Whitelist) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

