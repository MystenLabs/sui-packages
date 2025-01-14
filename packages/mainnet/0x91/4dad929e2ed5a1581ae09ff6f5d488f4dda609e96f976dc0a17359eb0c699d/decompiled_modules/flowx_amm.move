module 0x914dad929e2ed5a1581ae09ff6f5d488f4dda609e96f976dc0a17359eb0c699d::flowx_amm {
    struct FlowxSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x914dad929e2ed5a1581ae09ff6f5d488f4dda609e96f976dc0a17359eb0c699d::config::Config, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, arg2, arg3);
        let (v1, v2) = 0x914dad929e2ed5a1581ae09ff6f5d488f4dda609e96f976dc0a17359eb0c699d::config::pay_fee<T1>(arg0, v0, arg3);
        let v3 = FlowxSwapEvent{
            amount_in    : 0x2::coin::value<T0>(&arg2),
            amount_out   : 0x2::coin::value<T1>(&v0) - v2,
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FlowxSwapEvent>(v3);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x914dad929e2ed5a1581ae09ff6f5d488f4dda609e96f976dc0a17359eb0c699d::config::Config, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T0>(arg1, arg2, arg3);
        let (v1, v2) = 0x914dad929e2ed5a1581ae09ff6f5d488f4dda609e96f976dc0a17359eb0c699d::config::pay_fee<T0>(arg0, v0, arg3);
        let v3 = FlowxSwapEvent{
            amount_in    : 0x2::coin::value<T1>(&arg2),
            amount_out   : 0x2::coin::value<T0>(&v0) - v2,
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FlowxSwapEvent>(v3);
        v1
    }

    // decompiled from Move bytecode v6
}

