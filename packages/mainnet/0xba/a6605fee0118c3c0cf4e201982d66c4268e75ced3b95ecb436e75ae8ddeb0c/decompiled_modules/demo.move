module 0xbaa6605fee0118c3c0cf4e201982d66c4268e75ced3b95ecb436e75ae8ddeb0c::demo {
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

    public entry fun create_People(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = People{
            id  : 0x2::object::new(arg1),
            age : arg0,
        };
        0x2::transfer::public_transfer<People>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_value(arg0: &mut D, arg1: u64) {
        arg0.v = arg1;
    }

    public fun value(arg0: &D) : u64 {
        arg0.v
    }

    // decompiled from Move bytecode v7
}

