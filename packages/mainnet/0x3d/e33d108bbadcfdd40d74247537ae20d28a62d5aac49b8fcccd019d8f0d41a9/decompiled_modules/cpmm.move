module 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::cpmm {
    struct CpQuoter has store {
        offset: u64,
        extension_fields: 0x2::bag::Bag,
    }

    public fun swap<T0, T1>(arg0: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, CpQuoter>, arg1: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::GlobalConfig, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::SwapResult {
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_package_version(arg1);
        check_invariance<T0, T1, CpQuoter>(arg0, k<T0, T1>(arg0), offset<T0, T1>(arg0));
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::swap<T0, T1, CpQuoter>(arg0, arg2, arg3, quote_swap<T0, T1>(arg0, arg1, arg5, arg4), arg6, arg7)
    }

    public fun new<T0, T1, T2, T3>(arg0: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::registry::Registry, arg1: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::GlobalConfig, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: u64, arg4: u64, arg5: &0x2::coin_registry::Currency<T2>, arg6: &0x2::coin_registry::Currency<T3>, arg7: &mut 0x2::tx_context::TxContext) : 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T2, T3, CpQuoter> {
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_package_version(arg1);
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg7));
        let v0 = CpQuoter{
            offset           : arg4,
            extension_fields : 0x2::bag::new(arg7),
        };
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::new<T2, T3, CpQuoter>(arg0, arg1, arg2, arg3, v0, arg5, arg6, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg7)
    }

    public(friend) fun check_invariance<T0, T1, T2: store>(arg0: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, T2>, arg1: u128, arg2: u64) {
        let v0 = k_external<T0, T1, T2>(arg0, arg2);
        assert!(v0 > 0, 1);
        assert!(v0 >= arg1, 0);
    }

    public fun k<T0, T1>(arg0: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, CpQuoter>) : u128 {
        k_external<T0, T1, CpQuoter>(arg0, offset<T0, T1>(arg0))
    }

    public fun k_external<T0, T1, T2: store>(arg0: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, T2>, arg1: u64) : u128 {
        let (v0, v1) = 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::balance_amounts<T0, T1, T2>(arg0);
        (v0 as u128) * ((v1 + arg1) as u128)
    }

    public fun new_and_share<T0, T1, T2, T3>(arg0: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::registry::Registry, arg1: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::GlobalConfig, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: u64, arg4: u64, arg5: &0x2::coin_registry::Currency<T2>, arg6: &0x2::coin_registry::Currency<T3>, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T2, T3, CpQuoter>>(new<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun offset<T0, T1>(arg0: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, CpQuoter>) : u64 {
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::quoter<T0, T1, CpQuoter>(arg0).offset
    }

    public fun pause_pool<T0, T1>(arg0: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, CpQuoter>, arg1: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_package_version(arg1);
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_pause_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::pause_pool<T0, T1, CpQuoter>(arg0, arg1);
    }

    public fun quote_swap<T0, T1>(arg0: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, CpQuoter>, arg1: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::GlobalConfig, arg2: u64, arg3: bool) : 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::quote::SwapQuote {
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_package_version(arg1);
        let (v0, v1) = 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::balance_amounts<T0, T1, CpQuoter>(arg0);
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::get_quote<T0, T1, CpQuoter>(arg0, arg1, arg2, quote_swap_impl(v0, v1, arg2, 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::quoter<T0, T1, CpQuoter>(arg0).offset, arg3), arg3, 0x1::option::none<u64>())
    }

    fun quote_swap_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        let (v0, v1) = if (arg4) {
            (arg1, arg2 + arg3)
        } else {
            (arg1 + arg3, arg2)
        };
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::base_math::safe_mul_div(v1, arg0, v0 + arg0)
    }

    public(friend) fun quote_swap_impl(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (arg4) {
            let v1 = quote_swap_(arg2, arg0, arg1, arg3, arg4);
            0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::assert_liquidity(arg1, v1);
            v1
        } else {
            let v2 = quote_swap_(arg2, arg1, arg0, arg3, arg4);
            0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::assert_liquidity(arg0, v2);
            v2
        }
    }

    public fun resume_pool<T0, T1>(arg0: &mut 0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::Pool<T0, T1, CpQuoter>, arg1: &0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_package_version(arg1);
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::global_config::check_pause_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        0x3de33d108bbadcfdd40d74247537ae20d28a62d5aac49b8fcccd019d8f0d41a9::pool::resume_pool<T0, T1, CpQuoter>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

