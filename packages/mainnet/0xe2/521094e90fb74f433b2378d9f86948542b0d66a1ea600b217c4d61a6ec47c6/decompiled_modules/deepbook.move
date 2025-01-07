module 0xe2521094e90fb74f433b2378d9f86948542b0d66a1ea600b217c4d61a6ec47c6::deepbook {
    struct DeepbookSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        account_cap: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xe2521094e90fb74f433b2378d9f86948542b0d66a1ea600b217c4d61a6ec47c6::config::Config, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0xdee9::custodian_v2::AccountCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg1, 0, arg3, v0, arg2, 0x2::coin::zero<T1>(arg5), arg4, arg5);
        let v4 = v2;
        let v5 = v1;
        let (v6, v7) = 0xe2521094e90fb74f433b2378d9f86948542b0d66a1ea600b217c4d61a6ec47c6::config::pay_fee<T1>(arg0, v4, arg5);
        let v8 = DeepbookSwapEvent{
            pool         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1),
            amount_in    : v0 - 0x2::coin::value<T0>(&v5),
            amount_out   : 0x2::coin::value<T1>(&v4) - v7,
            a2b          : true,
            by_amount_in : true,
            account_cap  : 0x2::object::id<0xdee9::custodian_v2::AccountCap>(arg3),
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookSwapEvent>(v8);
        0xe2521094e90fb74f433b2378d9f86948542b0d66a1ea600b217c4d61a6ec47c6::utils::transfer_or_destroy_coin<T0>(v5, arg5);
        v6
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xe2521094e90fb74f433b2378d9f86948542b0d66a1ea600b217c4d61a6ec47c6::config::Config, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0xdee9::custodian_v2::AccountCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg1, 0, arg3, v0, arg4, arg2, arg5);
        let v4 = v2;
        let v5 = v1;
        let (v6, v7) = 0xe2521094e90fb74f433b2378d9f86948542b0d66a1ea600b217c4d61a6ec47c6::config::pay_fee<T0>(arg0, v5, arg5);
        let v8 = DeepbookSwapEvent{
            pool         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1),
            amount_in    : v0 - 0x2::coin::value<T1>(&v4),
            amount_out   : 0x2::coin::value<T0>(&v5) - v7,
            a2b          : false,
            by_amount_in : true,
            account_cap  : 0x2::object::id<0xdee9::custodian_v2::AccountCap>(arg3),
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookSwapEvent>(v8);
        0xe2521094e90fb74f433b2378d9f86948542b0d66a1ea600b217c4d61a6ec47c6::utils::transfer_or_destroy_coin<T1>(v4, arg5);
        v6
    }

    public fun transfer_account_cap(arg0: 0xdee9::custodian_v2::AccountCap, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdee9::custodian_v2::AccountCap>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

