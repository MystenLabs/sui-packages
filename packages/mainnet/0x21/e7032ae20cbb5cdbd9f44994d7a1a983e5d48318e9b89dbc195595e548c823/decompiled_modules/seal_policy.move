module 0x21e7032ae20cbb5cdbd9f44994d7a1a983e5d48318e9b89dbc195595e548c823::seal_policy {
    struct Allowlist has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
        creator: address,
        members: 0x2::table::Table<address, bool>,
    }

    struct AllowlistAdminCap has store, key {
        id: 0x2::object::UID,
        allowlist_id: 0x2::object::ID,
    }

    public entry fun add_to_allowlist(arg0: &mut Allowlist, arg1: &AllowlistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, bool>(&arg0.members, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.members, arg2, true);
        };
    }

    public entry fun create_allowlist(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::table::new<address, bool>(arg1);
        0x2::table::add<address, bool>(&mut v1, v0, true);
        let v2 = Allowlist{
            id      : 0x2::object::new(arg1),
            form_id : arg0,
            creator : v0,
            members : v1,
        };
        let v3 = AllowlistAdminCap{
            id           : 0x2::object::new(arg1),
            allowlist_id : 0x2::object::id<Allowlist>(&v2),
        };
        0x2::transfer::share_object<Allowlist>(v2);
        0x2::transfer::transfer<AllowlistAdminCap>(v3, v0);
    }

    public fun get_allowlist_id(arg0: &Allowlist) : 0x2::object::ID {
        0x2::object::id<Allowlist>(arg0)
    }

    public fun is_member(arg0: &Allowlist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.members, arg1)
    }

    public entry fun remove_from_allowlist(arg0: &mut Allowlist, arg1: &AllowlistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, bool>(&arg0.members, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.members, arg2);
        };
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &Allowlist, arg2: &0x2::tx_context::TxContext) {
        assert!(is_member(arg1, 0x2::tx_context::sender(arg2)), 0);
    }

    // decompiled from Move bytecode v7
}

