module 0x288e60f1b0405fa5368ad9d1889f7bc3be710112518243e443169f52b29cb584::demo {
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

    struct Alive has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun add_is_alive(arg0: &mut People, arg1: u64) {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::add<Alive, u64>(&mut arg0.id, v0, arg1);
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

