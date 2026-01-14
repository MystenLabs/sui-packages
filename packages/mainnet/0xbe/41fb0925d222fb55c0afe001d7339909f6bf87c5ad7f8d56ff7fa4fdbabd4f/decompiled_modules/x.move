module 0xbe41fb0925d222fb55c0afe001d7339909f6bf87c5ad7f8d56ff7fa4fdbabd4f::x {
    struct AC has key {
        id: 0x2::object::UID,
    }

    struct V has key {
        id: 0x2::object::UID,
        a: address,
        m: 0x2::vec_set::VecSet<address>,
    }

    public entry fun cv(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = V{
            id : 0x2::object::new(arg0),
            a  : v0,
            m  : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v1.m, v0);
        0x2::transfer::share_object<V>(v1);
    }

    // decompiled from Move bytecode v6
}

