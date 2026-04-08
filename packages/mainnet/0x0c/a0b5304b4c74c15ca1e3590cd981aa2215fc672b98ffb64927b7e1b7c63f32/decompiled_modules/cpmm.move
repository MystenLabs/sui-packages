module 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::cpmm {
    struct CpQuoter has store {
        offset: u64,
        extension_fields: 0x2::bag::Bag,
    }

    public fun swap<T0, T1, T2: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, CpQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::SwapResult {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        check_invariance<T0, T1, CpQuoter, T2>(arg0, k<T0, T1, T2>(arg0), offset<T0, T1, T2>(arg0));
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::swap<T0, T1, CpQuoter, T2>(arg0, arg2, arg3, quote_swap<T0, T1, T2>(arg0, arg1, arg5, arg4), arg6, arg7)
    }

    public fun new<T0, T1, T2, T3, T4: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::Registry, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T2>, arg5: &0x2::coin::CoinMetadata<T3>, arg6: &mut 0x2::coin::CoinMetadata<T4>, arg7: 0x2::coin::TreasuryCap<T4>, arg8: &mut 0x2::tx_context::TxContext) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T2, T3, CpQuoter, T4> {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg8));
        let v0 = CpQuoter{
            offset           : arg3,
            extension_fields : 0x2::bag::new(arg8),
        };
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::new<T2, T3, CpQuoter, T4>(arg0, arg2, v0, arg4, arg5, arg6, arg7, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg8)
    }

    public(friend) fun check_invariance<T0, T1, T2: store, T3: drop>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg1: u128, arg2: u64) {
        let v0 = k_external<T0, T1, T2, T3>(arg0, arg2);
        assert!(v0 > 0, 1);
        assert!(v0 >= arg1, 0);
    }

    public fun k<T0, T1, T2: drop>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, CpQuoter, T2>) : u128 {
        k_external<T0, T1, CpQuoter, T2>(arg0, offset<T0, T1, T2>(arg0))
    }

    public fun k_external<T0, T1, T2: store, T3: drop>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg1: u64) : u128 {
        let (v0, v1) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amounts<T0, T1, T2, T3>(arg0);
        (v0 as u128) * ((v1 + arg1) as u128)
    }

    public fun new_and_share<T0, T1, T2, T3, T4: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::Registry, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T2>, arg5: &0x2::coin::CoinMetadata<T3>, arg6: &mut 0x2::coin::CoinMetadata<T4>, arg7: 0x2::coin::TreasuryCap<T4>, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T2, T3, CpQuoter, T4>>(new<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun offset<T0, T1, T2: drop>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, CpQuoter, T2>) : u64 {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T0, T1, CpQuoter, T2>(arg0).offset
    }

    public fun pause_pool<T0, T1, T2: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, CpQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_pause_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::pause_pool<T0, T1, CpQuoter, T2>(arg0, arg1);
    }

    public fun quote_swap<T0, T1, T2: drop>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, CpQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: u64, arg3: bool) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::quote::SwapQuote {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        let (v0, v1) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amounts<T0, T1, CpQuoter, T2>(arg0);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::get_quote<T0, T1, CpQuoter, T2>(arg0, arg1, arg2, quote_swap_impl(v0, v1, arg2, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T0, T1, CpQuoter, T2>(arg0).offset, arg3), arg3, 0x1::option::none<u64>())
    }

    fun quote_swap_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        let (v0, v1) = if (arg4) {
            (arg1, arg2 + arg3)
        } else {
            (arg1 + arg3, arg2)
        };
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::base_math::safe_mul_div(v1, arg0, v0 + arg0)
    }

    public(friend) fun quote_swap_impl(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (arg4) {
            let v1 = quote_swap_(arg2, arg0, arg1, arg3, arg4);
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::assert_liquidity(arg1, v1);
            v1
        } else {
            let v2 = quote_swap_(arg2, arg1, arg0, arg3, arg4);
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::assert_liquidity(arg0, v2);
            v2
        }
    }

    public fun resume_pool<T0, T1, T2: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, CpQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_pause_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::resume_pool<T0, T1, CpQuoter, T2>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

