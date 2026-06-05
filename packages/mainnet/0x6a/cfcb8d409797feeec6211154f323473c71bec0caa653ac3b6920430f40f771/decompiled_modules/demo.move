module 0x6acfcb8d409797feeec6211154f323473c71bec0caa653ac3b6920430f40f771::demo {
    struct D has store, key {
        id: 0x2::object::UID,
        v: u64,
    }

    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
    }

    struct School has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun add_school_age(arg0: &mut People, arg1: u64) {
        let v0 = School{dummy_field: false};
        0x2::dynamic_field::add<School, u64>(&mut arg0.id, v0, arg1);
    }

    public entry fun create_D(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = D{
            id : 0x2::object::new(arg1),
            v  : arg0,
        };
        0x2::transfer::public_transfer<D>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_value(arg0: &mut D, arg1: u64) {
        arg0.v = arg1;
    }

    public fun value(arg0: &D) : u64 {
        arg0.v
    }

    // decompiled from Move bytecode v7
}

