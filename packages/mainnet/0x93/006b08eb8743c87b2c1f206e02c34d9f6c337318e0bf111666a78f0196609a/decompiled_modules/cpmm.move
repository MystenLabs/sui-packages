module 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::cpmm {
    struct CpQuoter has store {
        version: 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::version::Version,
        offset: u64,
    }

    public fun swap<T0, T1, T2: drop>(arg0: &mut 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, CpQuoter, T2>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::SwapResult {
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::version::assert_version_and_upgrade(&mut 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::quoter_mut<T0, T1, CpQuoter, T2>(arg0).version, 1);
        check_invariance<T0, T1, CpQuoter, T2>(arg0, k<T0, T1, T2>(arg0), offset<T0, T1, T2>(arg0));
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::swap<T0, T1, CpQuoter, T2>(arg0, arg1, arg2, quote_swap<T0, T1, T2>(arg0, arg4, arg3), arg5, arg6)
    }

    public(friend) fun check_invariance<T0, T1, T2: store, T3: drop>(arg0: &0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, T2, T3>, arg1: u128, arg2: u64) {
        let v0 = k_external<T0, T1, T2, T3>(arg0, arg2);
        assert!(v0 > 0, 2);
        assert!(v0 >= arg1, 1);
    }

    public fun k<T0, T1, T2: drop>(arg0: &0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, CpQuoter, T2>) : u128 {
        k_external<T0, T1, CpQuoter, T2>(arg0, offset<T0, T1, T2>(arg0))
    }

    public fun k_external<T0, T1, T2: store, T3: drop>(arg0: &0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, T2, T3>, arg1: u64) : u128 {
        let (v0, v1) = 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::balance_amounts<T0, T1, T2, T3>(arg0);
        (v0 as u128) * ((v1 + arg1) as u128)
    }

    entry fun migrate<T0, T1, T2: drop>(arg0: &mut 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, CpQuoter, T2>, arg1: &0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::global_admin::GlobalAdmin) {
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::version::migrate_(&mut 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::quoter_mut<T0, T1, CpQuoter, T2>(arg0).version, 1);
    }

    public fun new<T0, T1, T2: drop>(arg0: &mut 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::registry::Registry, arg1: u64, arg2: u64, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &mut 0x2::coin::CoinMetadata<T2>, arg6: 0x2::coin::TreasuryCap<T2>, arg7: &mut 0x2::tx_context::TxContext) : 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, CpQuoter, T2> {
        let v0 = CpQuoter{
            version : 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::version::new(1),
            offset  : arg2,
        };
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::new<T0, T1, CpQuoter, T2>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7)
    }

    public fun offset<T0, T1, T2: drop>(arg0: &0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, CpQuoter, T2>) : u64 {
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::quoter<T0, T1, CpQuoter, T2>(arg0).offset
    }

    public fun quote_swap<T0, T1, T2: drop>(arg0: &0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::Pool<T0, T1, CpQuoter, T2>, arg1: u64, arg2: bool) : 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::quote::SwapQuote {
        let (v0, v1) = 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::balance_amounts<T0, T1, CpQuoter, T2>(arg0);
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::get_quote<T0, T1, CpQuoter, T2>(arg0, arg1, quote_swap_impl(v0, v1, arg1, 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::quoter<T0, T1, CpQuoter, T2>(arg0).offset, arg2), arg2)
    }

    fun quote_swap_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        let (v0, v1) = if (arg4) {
            (arg1, arg2 + arg3)
        } else {
            (arg1 + arg3, arg2)
        };
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::math::safe_mul_div(v1, arg0, v0 + arg0)
    }

    public(friend) fun quote_swap_impl(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (arg4) {
            let v0 = quote_swap_(arg2, arg0, arg1, arg3, arg4);
            0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::assert_liquidity(arg1, v0);
            return v0
        };
        let v1 = quote_swap_(arg2, arg1, arg0, arg3, arg4);
        0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::pool::assert_liquidity(arg0, v1);
        v1
    }

    // decompiled from Move bytecode v6
}

