module 0x9b8fb9e0315bce2251c1d5b6f0e0955dcc5b072ddddaf83e631a8c656acbb82::ownership {
    struct Ownership<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        of: 0x2::object::ID,
    }

    public fun assert_owner<T0: drop, T1: key>(arg0: &Ownership<T0>, arg1: &T1) {
        assert!(is_owner<T0, T1>(arg0, arg1), 0);
    }

    public fun create_ownership<T0: drop>(arg0: T0, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Ownership<T0> {
        Ownership<T0>{
            id : 0x2::object::new(arg2),
            of : arg1,
        }
    }

    public fun is_owner<T0: drop, T1: key>(arg0: &Ownership<T0>, arg1: &T1) : bool {
        arg0.of == 0x2::object::id<T1>(arg1)
    }

    // decompiled from Move bytecode v6
}

