module 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_fun {
    struct PackageVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun check(arg0: &PackageVersion) {
        assert!(arg0.version == 1, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageVersion{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<PackageVersion>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

