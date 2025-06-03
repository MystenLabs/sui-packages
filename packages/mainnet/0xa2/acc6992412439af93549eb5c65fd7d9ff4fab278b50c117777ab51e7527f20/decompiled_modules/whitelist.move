module 0xa2acc6992412439af93549eb5c65fd7d9ff4fab278b50c117777ab51e7527f20::whitelist {
    struct Whitelist has store, key {
        id: 0x2::object::UID,
        addresses: 0x2::table::Table<address, bool>,
    }

    struct WhitelistAdminCap has store, key {
        id: 0x2::object::UID,
        whitelist_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Whitelist, WhitelistAdminCap) {
        let v0 = Whitelist{
            id        : 0x2::object::new(arg0),
            addresses : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = WhitelistAdminCap{
            id           : 0x2::object::new(arg0),
            whitelist_id : 0x2::object::id<Whitelist>(&v0),
        };
        (v0, v1)
    }

    public fun add_to_whitelist(arg0: &WhitelistAdminCap, arg1: &mut Whitelist, arg2: address) {
        assert_correct_whitelist_admin_cap(arg0, arg1);
        0x2::table::add<address, bool>(&mut arg1.addresses, arg2, true);
    }

    public fun assert_address_is_whitelisted(arg0: &Whitelist, arg1: address) {
        assert!(contains_address(arg0, arg1), 1);
    }

    fun assert_correct_whitelist_admin_cap(arg0: &WhitelistAdminCap, arg1: &Whitelist) {
        assert!(arg0.whitelist_id == 0x2::object::id<Whitelist>(arg1), 0);
    }

    public fun contains_address(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.addresses, arg1)
    }

    public fun remove_from_whitelist(arg0: &WhitelistAdminCap, arg1: &mut Whitelist, arg2: address) {
        assert_correct_whitelist_admin_cap(arg0, arg1);
        0x2::table::remove<address, bool>(&mut arg1.addresses, arg2);
    }

    // decompiled from Move bytecode v6
}

