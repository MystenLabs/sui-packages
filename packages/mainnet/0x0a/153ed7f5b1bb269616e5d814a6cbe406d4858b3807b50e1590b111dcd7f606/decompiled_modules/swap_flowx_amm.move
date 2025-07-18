module 0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::swap_flowx_amm {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::swap_transaction::SwapTransaction<T2, T3>, arg3: &0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::state::State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, arg1, arg4);
        let v1 = 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container>(arg0);
        0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::swap_event::emit_common_swap<T0, T1>(0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::consts::DEX_FLOWX_AMM(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T1>, arg2: &0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::swap_transaction::SwapTransaction<T2, T3>, arg3: &0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::state::State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg0, arg1, arg4);
        let v1 = 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container>(arg0);
        0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::swap_event::emit_common_swap<T0, T1>(0xa153ed7f5b1bb269616e5d814a6cbe406d4858b3807b50e1590b111dcd7f606::consts::DEX_FLOWX_AMM(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T1>(&arg1), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

