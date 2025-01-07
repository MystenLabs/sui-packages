module 0x139cc6e573fac2726fda782e1df80eb3a61eee5721014f262f8b983784799bd::help {
    public fun transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun c_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 444);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun c_transfer1<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_all<T0>(arg0, arg2);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 444);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun convert<T0>(arg0: 0x2::coin::Coin<T0>) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        v0
    }

    public fun convert1<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg0, 0)
    }

    public fun merge_all<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    // decompiled from Move bytecode v6
}

