module 0xbbc3dc993218b13253c8b4ccc2f39fbc3c8964850d7e6a913c820f2c2f0ffcb5::flash {
    struct Oops<phantom T0> has key {
        id: 0x2::object::UID,
        damn: 0x2::balance::Balance<T0>,
    }

    public fun create_oops<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oops<T0>{
            id   : 0x2::object::new(arg0),
            damn : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Oops<T0>>(v0);
    }

    public fun doop<T0>(arg0: &mut Oops<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.damn, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun woop<T0>(arg0: &mut Oops<T0>, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::address::from_bytes(arg2) == 0x2::tx_context::sender(arg3), 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.damn, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

