module 0x7dea8cca3f9970e8c52813d7a0cfb6c8e481fd92e9186834e1e3b58db2068029::whitelist {
    struct Whitelist has key {
        id: 0x2::object::UID,
        version: u64,
        addresses: 0x2::table::Table<address, bool>,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
        wl_id: 0x2::object::ID,
    }

    public fun add(arg0: &mut Whitelist, arg1: &Cap, arg2: address) {
        assert!(arg1.wl_id == 0x2::object::id<Whitelist>(arg0), 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.addresses, arg2), 3);
        0x2::table::add<address, bool>(&mut arg0.addresses, arg2, true);
    }

    public fun remove(arg0: &mut Whitelist, arg1: &Cap, arg2: address) {
        assert!(arg1.wl_id == 0x2::object::id<Whitelist>(arg0), 2);
        assert!(0x2::table::contains<address, bool>(&arg0.addresses, arg2), 4);
        0x2::table::remove<address, bool>(&mut arg0.addresses, arg2);
    }

    fun check_policy(arg0: address, arg1: vector<u8>, arg2: &Whitelist) : bool {
        assert!(arg2.version == 1, 5);
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
        0x2::table::contains<address, bool>(&arg2.addresses, arg0)
    }

    public fun create_whitelist(arg0: &mut 0x2::tx_context::TxContext) : (Cap, Whitelist) {
        let v0 = Whitelist{
            id        : 0x2::object::new(arg0),
            version   : 1,
            addresses : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = Cap{
            id    : 0x2::object::new(arg0),
            wl_id : 0x2::object::id<Whitelist>(&v0),
        };
        (v1, v0)
    }

    entry fun create_whitelist_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_whitelist(arg0);
        share_whitelist(v1);
        0x2::transfer::public_transfer<Cap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Whitelist, arg2: &0x2::tx_context::TxContext) {
        assert!(check_policy(0x2::tx_context::sender(arg2), arg0, arg1), 1);
    }

    public fun share_whitelist(arg0: Whitelist) {
        0x2::transfer::share_object<Whitelist>(arg0);
    }

    // decompiled from Move bytecode v6
}

