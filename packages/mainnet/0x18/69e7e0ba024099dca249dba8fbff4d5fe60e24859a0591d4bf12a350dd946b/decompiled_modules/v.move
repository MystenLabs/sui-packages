module 0x1869e7e0ba024099dca249dba8fbff4d5fe60e24859a0591d4bf12a350dd946b::v {
    struct V<phantom T0> has key {
        id: 0x2::object::UID,
        b: 0x2::balance::Balance<T0>,
    }

    struct A has store, key {
        id: 0x2::object::UID,
        a: vector<address>,
    }

    public fun a_add(arg0: &mut A, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x175f25c26747f190873f5bb9c1b18f98d05f1304244c5712e5603d18dc718858, 1);
        0x1::vector::append<address>(&mut arg0.a, arg1);
    }

    fun a_check(arg0: &A, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.a, &v0), 2);
    }

    public fun a_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = A{
            id : 0x2::object::new(arg0),
            a  : 0x1::vector::singleton<address>(@0x175f25c26747f190873f5bb9c1b18f98d05f1304244c5712e5603d18dc718858),
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

