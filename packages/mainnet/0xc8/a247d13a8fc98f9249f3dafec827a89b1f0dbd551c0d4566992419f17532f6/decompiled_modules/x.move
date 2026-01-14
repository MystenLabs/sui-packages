module 0xc8a247d13a8fc98f9249f3dafec827a89b1f0dbd551c0d4566992419f17532f6::x {
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

