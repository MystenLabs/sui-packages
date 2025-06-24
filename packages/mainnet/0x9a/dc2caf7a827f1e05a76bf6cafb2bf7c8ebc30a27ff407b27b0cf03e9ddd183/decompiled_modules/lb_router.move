module 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_router {
    struct AddLiquidityEvent has copy, drop {
        ids: vector<u32>,
        liquidity_minted: vector<u256>,
        token_ids: vector<0x2::object::ID>,
    }

    struct FetchPathEvent has copy, drop {
        pair_ids: vector<0x2::object::ID>,
        bin_steps: vector<u16>,
        versions: vector<u8>,
        token_path: vector<0x1::type_name::TypeName>,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u16, arg2: u32, arg3: u32, arg4: vector<u32>, arg5: vector<bool>, arg6: vector<u64>, arg7: vector<u64>, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::LBTokenBucket, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u32>(&arg4) == 0x1::vector::length<bool>(&arg5), 6011);
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair_mut<T0, T1>(arg0);
        assert!(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_bin_step<T0, T1>(v0) == arg1, 6004);
        let v1 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_active_id<T0, T1>(v0);
        assert!(v1 >= arg2 - arg3 && v1 <= arg2 + arg3, 6004);
        let (v2, v3, v4) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::mint<T0, T1>(v0, convert_deltas_to_ids(&arg4, &arg5, v1), arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v5 = AddLiquidityEvent{
            ids              : v2,
            liquidity_minted : v3,
            token_ids        : v4,
        };
        0x2::event::emit<AddLiquidityEvent>(v5);
    }

    fun convert_deltas_to_ids(arg0: &vector<u32>, arg1: &vector<bool>, arg2: u32) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::length<u32>(arg0);
        assert!(v1 == 0x1::vector::length<bool>(arg1), 6011);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = if (*0x1::vector::borrow<bool>(arg1, v2)) {
                arg2 + *0x1::vector::borrow<u32>(arg0, v2)
            } else {
                arg2 - *0x1::vector::borrow<u32>(arg0, v2)
            };
            0x1::vector::push_back<u32>(&mut v0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public fun create_path(arg0: vector<0x2::object::ID>, arg1: vector<u16>, arg2: vector<0x1::type_name::TypeName>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0);
        assert!(v0 == 0x1::vector::length<u16>(&arg1), 6000);
        assert!(v0 + 1 == 0x1::vector::length<0x1::type_name::TypeName>(&arg2), 6000);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, 2);
            v2 = v2 + 1;
        };
        let v3 = FetchPathEvent{
            pair_ids   : arg0,
            bin_steps  : arg1,
            versions   : v1,
            token_path : arg2,
        };
        0x2::event::emit<FetchPathEvent>(v3);
    }

    public fun get_amount_in<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, v2) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_swap_in<T0, T1>(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair<T0, T1>(arg0), arg1, arg2, arg3);
        assert!(v1 == 0, 6009);
        (v0, v2)
    }

    public fun get_amount_out<T0, T1>(arg0: &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1, v2) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_swap_out<T0, T1>(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair<T0, T1>(arg0), arg1, arg2, arg3);
        assert!(v0 == 0, 6009);
        (v1, v2)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u128, arg2: u128, arg3: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::LBTokenBucket, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_token::bucket_tokens_count(arg3) > 0, 6014);
        let (v0, v1, _) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::burn<T0, T1>(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair_mut<T0, T1>(arg0), arg3, arg4);
        let v3 = v1;
        let v4 = v0;
        assert!(0x2::coin::value<T0>(&v4) >= (arg1 as u64), 6001);
        assert!(0x2::coin::value<T1>(&v3) >= (arg2 as u64), 6001);
        (v4, v3)
    }

    public fun swap_exact_tokens_for_tokens<T0, T1>(arg0: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u128, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::clock::timestamp_ms(arg7) / 1000 <= arg6, 6005);
        let (v0, v1) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::swap<T0, T1>(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair_mut<T0, T1>(arg0), arg5, arg2, arg3, arg4, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg5) {
            0x2::coin::value<T1>(&v2)
        } else {
            0x2::coin::value<T0>(&v3)
        };
        assert!((v4 as u128) >= arg1, 6001);
        (v3, v2)
    }

    public fun swap_tokens_for_exact_tokens<T0, T1>(arg0: &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::LBPairWrapper<T0, T1>, arg1: u64, arg2: u64, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::clock::timestamp_ms(arg8) / 1000 <= arg7, 6005);
        let (v0, v1, _) = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::get_swap_in<T0, T1>(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair<T0, T1>(arg0), arg1, arg6, arg8);
        assert!(v1 == 0, 6009);
        assert!(v0 <= arg2, 6002);
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::swap<T0, T1>(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory::get_lb_pair_mut<T0, T1>(arg0), arg6, arg3, arg4, arg5, arg8, arg9)
    }

    // decompiled from Move bytecode v6
}

