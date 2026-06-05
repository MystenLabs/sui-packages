module 0x286f2edea8428a59c082e1ff83d5f498731022b8aa9503abfe918de50f1548c9::demo {
    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
    }

    public entry fun create_people(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = People{
            id  : 0x2::object::new(arg1),
            age : arg0,
        };
        0x2::transfer::public_transfer<People>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun get_age(arg0: &People) : u64 {
        arg0.age
    }

    public entry fun set_age(arg0: &mut People, arg1: u64) {
        arg0.age = arg1;
    }

    // decompiled from Move bytecode v7
}

