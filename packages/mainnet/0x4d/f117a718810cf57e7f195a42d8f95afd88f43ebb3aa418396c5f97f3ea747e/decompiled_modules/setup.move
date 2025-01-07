module 0x4df117a718810cf57e7f195a42d8f95afd88f43ebb3aa418396c5f97f3ea747e::setup {
    struct A has store, key {
        id: 0x2::object::UID,
    }

    struct B has store, key {
        id: 0x2::object::UID,
    }

    struct C has store, key {
        id: 0x2::object::UID,
        x: 0x2::table::Table<u64, B>,
    }

    public fun create_a(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = A{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<A>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    public fun create_c(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        0x2::tx_context::sender(arg1);
        let v1 = 0x2::table::new<u64, B>(arg1);
        while (v0 < arg0) {
            let v2 = B{id: 0x2::object::new(arg1)};
            0x2::table::add<u64, B>(&mut v1, v0, v2);
            v0 = v0 + 1;
        };
        let v3 = C{
            id : 0x2::object::new(arg1),
            x  : v1,
        };
        0x2::transfer::transfer<C>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun delete_a(arg0: A) {
        let A { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun delete_b(arg0: &mut C, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1) {
            let B { id: v1 } = 0x2::table::remove<u64, B>(&mut arg0.x, v0);
            0x2::object::delete(v1);
            v0 = v0 + 1;
        };
    }

    public fun delete_many_a(arg0: vector<A>) {
        while (0 < 0x1::vector::length<A>(&arg0)) {
            let A { id: v0 } = 0x1::vector::pop_back<A>(&mut arg0);
            0x2::object::delete(v0);
        };
        0x1::vector::destroy_empty<A>(arg0);
    }

    // decompiled from Move bytecode v6
}

