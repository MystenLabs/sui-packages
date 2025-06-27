module 0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::token_interface {
    public(friend) fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::tlp::TLP>(), 0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::error::liquidity_token_not_existed());
        0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::tlp::burn<T0>(arg0, arg1)
    }

    public(friend) fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::tlp::TLP>(), 0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::error::liquidity_token_not_existed());
        0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::tlp::mint<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

