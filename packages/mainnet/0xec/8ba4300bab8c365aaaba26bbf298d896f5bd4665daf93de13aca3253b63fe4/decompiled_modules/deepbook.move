module 0xec8ba4300bab8c365aaaba26bbf298d896f5bd4665daf93de13aca3253b63fe4::deepbook {
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

    public fun swap<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0xdee9::custodian_v2::AccountCap, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::coin::value<T1>(&arg5);
        if (arg7) {
            let v2 = if (arg1) {
                v0
            } else {
                v1
            };
            arg2 = v2;
        };
        if (arg1) {
            let (v7, v8) = swap_base_to_quote<T0, T1>(arg0, arg6, arg2, arg3, arg4, arg5, arg8, arg9);
            let v9 = v8;
            let v10 = v7;
            let v11 = 0x2::coin::value<T0>(&v10);
            let v12 = 0x2::coin::value<T1>(&v9);
            let v13 = if (arg1) {
                v0 - v11
            } else {
                v1 - v12
            };
            let v14 = if (arg1) {
                v12 - v1
            } else {
                v11 - v0
            };
            let v15 = DeepbookSwapEvent{
                pool         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg0),
                amount_in    : v13,
                amount_out   : v14,
                a2b          : arg1,
                by_amount_in : true,
                account_cap  : 0x2::object::id<0xdee9::custodian_v2::AccountCap>(arg6),
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<DeepbookSwapEvent>(v15);
            (v10, v9, v13, v14)
        } else {
            let (v16, v17) = swap_quote_to_base<T0, T1>(arg0, arg6, arg2, arg3, arg4, arg5, arg8, arg9);
            let v18 = v17;
            let v19 = v16;
            let v20 = 0x2::coin::value<T0>(&v19);
            let v21 = 0x2::coin::value<T1>(&v18);
            let v22 = if (arg1) {
                v0 - v20
            } else {
                v1 - v21
            };
            let v23 = if (arg1) {
                v21 - v1
            } else {
                v20 - v0
            };
            let v24 = DeepbookSwapEvent{
                pool         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg0),
                amount_in    : v22,
                amount_out   : v23,
                a2b          : arg1,
                by_amount_in : true,
                account_cap  : 0x2::object::id<0xdee9::custodian_v2::AccountCap>(arg6),
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<DeepbookSwapEvent>(v24);
            (v19, v18, v22, v23)
        }
    }

    public fun swap_base_to_quote<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg2, 2);
        let (v0, v1, v2) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg0, 0, arg1, arg2, 0x2::coin::split<T0>(&mut arg4, arg2, arg7), 0x2::coin::zero<T1>(arg7), arg6, arg7);
        assert!(v2 >= arg3, 1);
        0x2::coin::join<T0>(&mut arg4, v0);
        0x2::coin::join<T1>(&mut arg5, v1);
        (arg4, arg5)
    }

    public fun swap_quote_to_base<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg5) >= arg2, 3);
        let (v0, v1, v2) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg0, 0, arg1, arg2, arg6, 0x2::coin::split<T1>(&mut arg5, arg2, arg7), arg7);
        assert!(v2 >= arg3, 1);
        0x2::coin::join<T0>(&mut arg4, v0);
        0x2::coin::join<T1>(&mut arg5, v1);
        (arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

