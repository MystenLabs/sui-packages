module 0x3f4edda9443284f9a7011a9250fcf7a5ded69a43f12b3c443d04942cb555ac6b::x {
    struct V<phantom T0> has key {
        id: 0x2::object::UID,
        b: 0x2::balance::Balance<T0>,
    }

    struct A has store, key {
        id: 0x2::object::UID,
        a: vector<address>,
    }

    public fun a_add(arg0: &mut A, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x873517189f1c8bf1f97ed218681d48cffd88b63effbfc73e91ce9ffb75d83e2f, 1);
        0x1::vector::append<address>(&mut arg0.a, arg1);
    }

    fun a_check(arg0: &A, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.a, &v0), 2);
    }

    public fun a_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = A{
            id : 0x2::object::new(arg0),
            a  : 0x1::vector::singleton<address>(@0x873517189f1c8bf1f97ed218681d48cffd88b63effbfc73e91ce9ffb75d83e2f),
        };
        0x2::transfer::share_object<A>(v0);
    }

    public fun v_new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = V<T0>{
            id : 0x2::object::new(arg1),
            b  : arg0,
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

