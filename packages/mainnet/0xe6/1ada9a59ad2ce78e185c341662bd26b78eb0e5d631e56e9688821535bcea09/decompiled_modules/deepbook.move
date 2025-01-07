module 0x5bce01814bf05fd605b528e1dfd419d1352cd3e25018a54797d59b7eb1eea4c3::deepbook {
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

    public fun swap<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0xdee9::custodian_v2::AccountCap, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
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
            let (v5, v6) = swap_base_to_quote<T0, T1>(arg0, arg6, arg2, arg3, arg4, arg5, arg8, arg9);
            let v7 = v6;
            let v8 = v5;
            let v9 = 0x2::coin::value<T0>(&v8);
            let v10 = 0x2::coin::value<T1>(&v7);
            let v11 = if (arg1) {
                v0 - v9
            } else {
                v1 - v10
            };
            let v12 = if (arg1) {
                v10 - v1
            } else {
                v9 - v0
            };
            let v13 = DeepbookSwapEvent{
                pool         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg0),
                amount_in    : v11,
                amount_out   : v12,
                a2b          : arg1,
                by_amount_in : true,
                account_cap  : 0x2::object::id<0xdee9::custodian_v2::AccountCap>(arg6),
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<DeepbookSwapEvent>(v13);
            (v8, v7)
        } else {
            let (v14, v15) = swap_quote_to_base<T0, T1>(arg0, arg6, arg2, arg3, arg4, arg5, arg8, arg9);
            let v16 = v15;
            let v17 = v14;
            let v18 = 0x2::coin::value<T0>(&v17);
            let v19 = 0x2::coin::value<T1>(&v16);
            let v20 = if (arg1) {
                v0 - v18
            } else {
                v1 - v19
            };
            let v21 = if (arg1) {
                v19 - v1
            } else {
                v18 - v0
            };
            let v22 = DeepbookSwapEvent{
                pool         : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg0),
                amount_in    : v20,
                amount_out   : v21,
                a2b          : arg1,
                by_amount_in : true,
                account_cap  : 0x2::object::id<0xdee9::custodian_v2::AccountCap>(arg6),
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<DeepbookSwapEvent>(v22);
            (v17, v16)
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

