module 0xd32371629cc08a3643029ded7fd614eef53c8e12dba6b274b0e39a5c0f613515::flowx_amm {
    struct FlowxSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun swap<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg3) {
            0x2::coin::value<T0>(&arg1)
        } else {
            0x2::coin::value<T1>(&arg2)
        };
        if (arg3) {
            let v1 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, v0, arg4), arg4);
            let v2 = FlowxSwapEvent{
                amount_in    : v0,
                amount_out   : 0x2::coin::value<T1>(&v1),
                a2b          : arg3,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<FlowxSwapEvent>(v2);
            0x2::coin::join<T1>(&mut arg2, v1);
        } else {
            let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg0, 0x2::coin::split<T1>(&mut arg2, v0, arg4), arg4);
            let v4 = FlowxSwapEvent{
                amount_in    : v0,
                amount_out   : 0x2::coin::value<T0>(&v3),
                a2b          : arg3,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<FlowxSwapEvent>(v4);
            0x2::coin::join<T0>(&mut arg1, v3);
        };
        (arg1, arg2)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg2);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, v0, true, arg2);
        0xd32371629cc08a3643029ded7fd614eef53c8e12dba6b274b0e39a5c0f613515::utils::transfer_or_destroy_coin<T0>(v1, arg2);
        v2
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg2);
        let (v1, v2) = swap<T0, T1>(arg0, v0, arg1, false, arg2);
        0xd32371629cc08a3643029ded7fd614eef53c8e12dba6b274b0e39a5c0f613515::utils::transfer_or_destroy_coin<T1>(v2, arg2);
        v1
    }

    // decompiled from Move bytecode v6
}

