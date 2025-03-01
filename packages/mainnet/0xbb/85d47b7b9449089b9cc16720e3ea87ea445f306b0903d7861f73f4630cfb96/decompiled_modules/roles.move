module 0xbb85d47b7b9449089b9cc16720e3ea87ea445f306b0903d7861f73f4630cfb96::roles {
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

