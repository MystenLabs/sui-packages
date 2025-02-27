module 0x59e8ea40b442a3ed9884155be784b7d0ff72e42ee7ac86e3be934db00b536a5::roles {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct Creator has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
    }

    public fun assert_collection_creator(arg0: &Creator, arg1: 0x2::object::ID) {
        assert!(arg0.collection == arg1, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun new_creator(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Creator {
        Creator{
            id         : 0x2::object::new(arg1),
            collection : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

