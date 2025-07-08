module 0x2::borrow {
    struct Referent<T0: store + key> has store {
        id: address,
        value: 0x1::option::Option<T0>,
    }

    struct Borrow {
        ref: address,
        obj: 0x2::object::ID,
    }

    public fun borrow<T0: store + key>(arg0: &mut Referent<T0>) : (T0, Borrow) {
        let v0 = 0x1::option::extract<T0>(&mut arg0.value);
        let v1 = Borrow{
            ref : arg0.id,
            obj : 0x2::object::id<T0>(&v0),
        };
        (v0, v1)
    }

    public fun destroy<T0: store + key>(arg0: Referent<T0>) : T0 {
        let Referent {
            id    : _,
            value : v1,
        } = arg0;
        0x1::option::destroy_some<T0>(v1)
    }

    public fun new<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Referent<T0> {
        Referent<T0>{
            id    : 0x2::tx_context::fresh_object_address(arg1),
            value : 0x1::option::some<T0>(arg0),
        }
    }

    public fun put_back<T0: store + key>(arg0: &mut Referent<T0>, arg1: T0, arg2: Borrow) {
        let Borrow {
            ref : v0,
            obj : v1,
        } = arg2;
        assert!(0x2::object::id<T0>(&arg1) == v1, 1);
        assert!(arg0.id == v0, 0);
        0x1::option::fill<T0>(&mut arg0.value, arg1);
    }

    // decompiled from Move bytecode v6
}

