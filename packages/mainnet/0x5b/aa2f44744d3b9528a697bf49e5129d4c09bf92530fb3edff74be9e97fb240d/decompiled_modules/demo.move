module 0x5baa2f44744d3b9528a697bf49e5129d4c09bf92530fb3edff74be9e97fb240d::demo {
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

    public entry fun add_is_alive(arg0: &mut People, arg1: bool) {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::add<Alive, bool>(&mut arg0.id, v0, arg1);
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

