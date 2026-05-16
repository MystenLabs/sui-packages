module 0x2f0ecfd1685a05749c7c07779cbb73a5eee9b6d11ff12e7f8126967c67521d7a::seal_policy {
    struct Allowlist has key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
        members: 0x2::table::Table<address, bool>,
    }

    struct AllowlistAdminCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
    }

    public entry fun add_to_allowlist(arg0: &mut Allowlist, arg1: &AllowlistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.form_id == arg1.form_id, 0);
        if (!0x2::table::contains<address, bool>(&arg0.members, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.members, arg2, true);
        };
    }

    public entry fun create_allowlist(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Allowlist{
            id      : 0x2::object::new(arg1),
            form_id : arg0,
            members : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Allowlist>(v0);
        let v1 = AllowlistAdminCap{
            id      : 0x2::object::new(arg1),
            form_id : arg0,
        };
        0x2::transfer::public_transfer<AllowlistAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_member(arg0: &Allowlist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.members, arg1)
    }

    public entry fun remove_from_allowlist(arg0: &mut Allowlist, arg1: &AllowlistAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.form_id == arg1.form_id, 0);
        if (0x2::table::contains<address, bool>(&arg0.members, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.members, arg2);
        };
    }

    public entry fun seal_approve(arg0: &Allowlist, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_member(arg0, 0x2::tx_context::sender(arg1)), 1);
    }

    // decompiled from Move bytecode v7
}

