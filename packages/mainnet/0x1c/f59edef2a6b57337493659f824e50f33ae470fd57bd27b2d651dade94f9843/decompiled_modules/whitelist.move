module 0x1cf59edef2a6b57337493659f824e50f33ae470fd57bd27b2d651dade94f9843::whitelist {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Whitelist has key {
        id: 0x2::object::UID,
        members: 0x2::table::Table<address, bool>,
    }

    struct WhitelistInitialized has copy, drop {
        whitelist_id: address,
        admin: address,
    }

    struct MemberAdded has copy, drop {
        whitelist_id: address,
        member: address,
    }

    struct MemberRemoved has copy, drop {
        whitelist_id: address,
        member: address,
    }

    public fun add(arg0: &AdminCap, arg1: &mut Whitelist, arg2: address) {
        assert!(!0x2::table::contains<address, bool>(&arg1.members, arg2), 2);
        0x2::table::add<address, bool>(&mut arg1.members, arg2, true);
        let v0 = MemberAdded{
            whitelist_id : 0x2::object::uid_to_address(&arg1.id),
            member       : arg2,
        };
        0x2::event::emit<MemberAdded>(v0);
    }

    public fun remove(arg0: &AdminCap, arg1: &mut Whitelist, arg2: address) {
        assert!(0x2::table::contains<address, bool>(&arg1.members, arg2), 3);
        0x2::table::remove<address, bool>(&mut arg1.members, arg2);
        let v0 = MemberRemoved{
            whitelist_id : 0x2::object::uid_to_address(&arg1.id),
            member       : arg2,
        };
        0x2::event::emit<MemberRemoved>(v0);
    }

    public fun assert_whitelisted(arg0: &Whitelist, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.members, arg1), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::new(arg0);
        let v2 = Whitelist{
            id      : v1,
            members : 0x2::table::new<address, bool>(arg0),
        };
        let v3 = WhitelistInitialized{
            whitelist_id : 0x2::object::uid_to_address(&v1),
            admin        : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<WhitelistInitialized>(v3);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Whitelist>(v2);
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.members, arg1)
    }

    // decompiled from Move bytecode v7
}

