module 0x956f9b3fb8668394eb05b30afd30c0612b629d9acff4928e8c2669ccaa988b43::storage {
    struct Storage has store, key {
        id: 0x2::object::UID,
        obligations: 0x2::table::Table<address, address>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id          : 0x2::object::new(arg0),
            obligations : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    // decompiled from Move bytecode v6
}

