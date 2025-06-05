module 0x16115de5d7beac67310513badc713bfbfc696ff5f035d8ebca61bbba94646fc7::v {
    struct V<phantom T0> has key {
        id: 0x2::object::UID,
        b: 0x2::balance::Balance<T0>,
    }

    struct A has store, key {
        id: 0x2::object::UID,
        a: vector<address>,
    }

    public fun a_add(arg0: &mut A, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x7aa0d7dcc49326257dc450071e46b017534c4249f3d60402ac81c65a0df635c9, 1);
        0x1::vector::append<address>(&mut arg0.a, arg1);
    }

    public fun a_check(arg0: &A, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.a, &v0), 2);
    }

    public fun a_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = A{
            id : 0x2::object::new(arg0),
            a  : 0x1::vector::singleton<address>(@0x7aa0d7dcc49326257dc450071e46b017534c4249f3d60402ac81c65a0df635c9),
        };
        0x2::transfer::share_object<A>(v0);
    }

    public fun v_new<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = V<T0>{
            id : 0x2::object::new(arg0),
            b  : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<V<T0>>(v0);
    }

    public fun xx<T0>(arg0: &mut A, arg1: &mut V<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        a_check(arg0, arg3);
        0x2::balance::split<T0>(&mut arg1.b, arg2)
    }

    public fun xy<T0>(arg0: &mut V<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg1) >= arg2, 3);
        0x2::balance::join<T0>(&mut arg0.b, 0x2::balance::split<T0>(&mut arg1, arg2));
        arg1
    }

    // decompiled from Move bytecode v6
}

