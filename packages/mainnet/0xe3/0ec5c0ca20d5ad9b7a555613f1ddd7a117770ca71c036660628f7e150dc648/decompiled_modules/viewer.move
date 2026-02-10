module 0xe30ec5c0ca20d5ad9b7a555613f1ddd7a117770ca71c036660628f7e150dc648::viewer {
    struct ViewerProfile has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        watch: 0x2::table::Table<0x2::object::ID, u64>,
    }

    public fun clear_watch(arg0: &mut ViewerProfile, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.watch, arg1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.watch, arg1);
        };
    }

    public fun create_viewer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = ViewerProfile{
            id      : 0x2::object::new(arg0),
            version : 1,
            owner   : v0,
            watch   : 0x2::table::new<0x2::object::ID, u64>(arg0),
        };
        0x2::transfer::transfer<ViewerProfile>(v1, v0);
    }

    public fun set_watch(arg0: &mut ViewerProfile, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.watch, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.watch, arg1) = arg2;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.watch, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

