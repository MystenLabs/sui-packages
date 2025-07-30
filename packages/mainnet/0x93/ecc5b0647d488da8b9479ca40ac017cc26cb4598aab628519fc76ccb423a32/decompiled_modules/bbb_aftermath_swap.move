module 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap {
    struct AftermathSwapEvent has copy, drop {
        type_in: 0x1::ascii::String,
        type_out: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        expected_out: u64,
    }

    struct AftermathSwap has copy, drop, store {
        type_in: 0x1::type_name::TypeName,
        type_out: 0x1::type_name::TypeName,
        decimals_in: u8,
        decimals_out: u8,
        feed_in: vector<u8>,
        feed_out: vector<u8>,
        pool_id: 0x2::object::ID,
        slippage: u64,
        max_age_secs: u64,
    }

    struct AftermathSwapPromise {
        swap: AftermathSwap,
    }

    public fun swap<T0, T1, T2>(arg0: AftermathSwapPromise, arg1: &mut 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_vault::BBBVault, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg6: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg7: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg8: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg9: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let AftermathSwapPromise { swap: v0 } = arg0;
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v3);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == v0.feed_in, 1001);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v4) == v0.feed_out, 1002);
        assert!(0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg4) == v0.pool_id, 1000);
        let v5 = 0x1::type_name::get<T1>();
        let v6 = 0x1::type_name::get<T2>();
        assert!(v5 == v0.type_in, 1003);
        assert!(v6 == v0.type_out, 1004);
        let v7 = 0x2::coin::from_balance<T1>(0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_vault::withdraw<T1>(arg1), arg11);
        let v8 = 0x2::coin::value<T1>(&v7);
        if (v8 == 0) {
            0x2::coin::destroy_zero<T1>(v7);
            return
        };
        let v9 = 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_pyth::calc_amount_out(arg2, arg3, v0.decimals_in, v0.decimals_out, v8, v0.max_age_secs, arg10);
        let v10 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg4, arg5, arg6, arg7, arg8, arg9, v7, v9, v0.slippage, arg11);
        let v11 = 0x2::coin::value<T2>(&v10);
        assert!(v11 >= (((v9 as u256) * (v0.slippage as u256) / 1000000000000000000) as u64), 1005);
        0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_vault::deposit<T2>(arg1, v10);
        let v12 = AftermathSwapEvent{
            type_in      : 0x1::type_name::into_string(v5),
            type_out     : 0x1::type_name::into_string(v6),
            amount_in    : v8,
            amount_out   : v11,
            expected_out : v9,
        };
        0x2::event::emit<AftermathSwapEvent>(v12);
    }

    public fun decimals_in(arg0: &AftermathSwap) : u8 {
        arg0.decimals_in
    }

    public fun decimals_out(arg0: &AftermathSwap) : u8 {
        arg0.decimals_out
    }

    public fun feed_in(arg0: &AftermathSwap) : &vector<u8> {
        &arg0.feed_in
    }

    public fun feed_out(arg0: &AftermathSwap) : &vector<u8> {
        &arg0.feed_out
    }

    public fun inner(arg0: &AftermathSwapPromise) : &AftermathSwap {
        &arg0.swap
    }

    public fun max_age_secs(arg0: &AftermathSwap) : u64 {
        arg0.max_age_secs
    }

    public fun new<T0, T1, T2>(arg0: &0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_admin::BBBAdminCap, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg6: u64, arg7: u64) : AftermathSwap {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T2>();
        let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_names<T0>(arg5);
        let v3 = 0x1::type_name::into_string(v0);
        assert!(0x1::vector::contains<0x1::ascii::String>(&v2, &v3), 1003);
        let v4 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_names<T0>(arg5);
        let v5 = 0x1::type_name::into_string(v1);
        assert!(0x1::vector::contains<0x1::ascii::String>(&v4, &v5), 1004);
        assert!((arg6 as u256) <= 1000000000000000000, 1006);
        assert!((arg6 as u256) >= 500000000000000000, 1007);
        assert!(arg7 < 3600, 1008);
        AftermathSwap{
            type_in      : v0,
            type_out     : v1,
            decimals_in  : arg1,
            decimals_out : arg2,
            feed_in      : arg3,
            feed_out     : arg4,
            pool_id      : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg5),
            slippage     : arg6,
            max_age_secs : arg7,
        }
    }

    public(friend) fun new_promise(arg0: AftermathSwap) : AftermathSwapPromise {
        AftermathSwapPromise{swap: arg0}
    }

    public fun pool_id(arg0: &AftermathSwap) : &0x2::object::ID {
        &arg0.pool_id
    }

    public fun slippage(arg0: &AftermathSwap) : u64 {
        arg0.slippage
    }

    public fun type_in(arg0: &AftermathSwap) : &0x1::type_name::TypeName {
        &arg0.type_in
    }

    public fun type_out(arg0: &AftermathSwap) : &0x1::type_name::TypeName {
        &arg0.type_out
    }

    // decompiled from Move bytecode v6
}

