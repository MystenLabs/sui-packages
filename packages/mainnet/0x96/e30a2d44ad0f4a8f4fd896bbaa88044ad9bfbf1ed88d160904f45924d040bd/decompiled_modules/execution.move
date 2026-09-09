module 0x96e30a2d44ad0f4a8f4fd896bbaa88044ad9bfbf1ed88d160904f45924d040bd::execution {
    public fun maybe_swap<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), arg2))
    }

    // decompiled from Move bytecode v7
}

