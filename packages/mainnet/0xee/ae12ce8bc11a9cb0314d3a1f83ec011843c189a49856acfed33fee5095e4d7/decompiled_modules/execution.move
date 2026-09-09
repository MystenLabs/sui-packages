module 0xeeae12ce8bc11a9cb0314d3a1f83ec011843c189a49856acfed33fee5095e4d7::execution {
    public fun maybe_swap<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4), 0, 0, 18446744073709551615, arg2, arg3, arg5))
    }

    // decompiled from Move bytecode v7
}

