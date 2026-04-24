module 0xe673167a29464abdd105f78b6e750f2158525673be82d021b6a9387c82f44800::r {
    struct LL<T0> {
        r: T0,
        a: u64,
    }

    struct R has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        access_list: vector<address>,
        total_swaps: u64,
        total_profit: u64,
    }

    struct SwapEvent has copy, drop {
        dex: u8,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    struct ProfitEvent has copy, drop {
        profit: u64,
        recipient: address,
    }

    public fun version(arg0: &R) : u64 {
        arg0.version
    }

    fun access_check(arg0: &R, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.access_list, &v0), 1);
    }

    public fun admin(arg0: &R) : address {
        arg0.admin
    }

    fun admin_check(arg0: &R, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
    }

    public fun aftermath_a2b<T0, T1, T2>(arg0: &mut R, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::balance::Balance<T0>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg8);
        let v0 = 0x2::coin::into_balance<T1>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(arg7, arg8), 0, 0, arg8));
        emit_swap_and_count(arg0, 18, true, 0x2::balance::value<T0>(&arg7), 0x2::balance::value<T1>(&v0));
        v0
    }

    public fun aftermath_b2a<T0, T1, T2>(arg0: &mut R, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::balance::Balance<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg8);
        let v0 = 0x2::coin::into_balance<T0>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T1, T0>(arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T1>(arg7, arg8), 0, 0, arg8));
        emit_swap_and_count(arg0, 18, false, 0x2::balance::value<T1>(&arg7), 0x2::balance::value<T0>(&v0));
        v0
    }

    public fun bluefin_a2b<T0, T1>(arg0: &mut R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, true, true, v0, 4295048016);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(arg3);
        emit_swap_and_count(arg0, 19, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun bluefin_b2a<T0, T1>(arg0: &mut R, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, false, true, v0, 79226673515401279992447579055);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(arg3);
        emit_swap_and_count(arg0, 19, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun cetus_a2b<T0, T1>(arg0: &mut R, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg6);
        let v0 = 0x2::balance::value<T0>(&arg4);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, true, true, v0, 4295048016, arg5);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, 0x2::balance::split<T0>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(arg4);
        emit_swap_and_count(arg0, 15, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun cetus_b2a<T0, T1>(arg0: &mut R, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg6);
        let v0 = 0x2::balance::value<T1>(&arg4);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, false, true, v0, 79226673515401279992447579055, arg5);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(arg4);
        emit_swap_and_count(arg0, 15, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun deepbook_borrow_base<T0, T1>(arg0: &R, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, 0x2::balance::Balance<T0>) {
        access_check(arg0, arg3);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, arg2, arg3);
        let v2 = LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>{
            r : v1,
            a : arg2,
        };
        (v2, 0x2::coin::into_balance<T0>(v0))
    }

    public fun deepbook_borrow_quote<T0, T1>(arg0: &R, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, 0x2::balance::Balance<T1>) {
        access_check(arg0, arg3);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, arg2, arg3);
        let v2 = LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>{
            r : v1,
            a : arg2,
        };
        (v2, 0x2::coin::into_balance<T1>(v0))
    }

    public fun deepbook_repay_base<T0, T1>(arg0: &mut R, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg4);
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v1), arg4), v0);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg2
    }

    public fun deepbook_repay_quote<T0, T1>(arg0: &mut R, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg4);
        let LL {
            r : v0,
            a : v1,
        } = arg3;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v1), arg4), v0);
        arg0.total_swaps = arg0.total_swaps + 1;
        arg2
    }

    public fun dipcoin_a2b<T0, T1>(arg0: &mut R, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg4);
        let v0 = 0x2::coin::into_balance<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(arg3, arg4), 0, arg4));
        emit_swap_and_count(arg0, 13, true, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&v0));
        v0
    }

    public fun dipcoin_b2a<T0, T1>(arg0: &mut R, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg4);
        let v0 = 0x2::coin::into_balance<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(arg3, arg4), 0, arg4));
        emit_swap_and_count(arg0, 13, false, 0x2::balance::value<T1>(&arg3), 0x2::balance::value<T0>(&v0));
        v0
    }

    public fun dlmm_a2b<T0, T1>(arg0: &mut R, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg7);
        let v0 = 0x2::balance::value<T0>(&arg5);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg3, arg4, true, true, v0, arg1, arg2, arg6, arg7);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg3, arg4, 0x2::balance::split<T0>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4, arg2);
        0x2::balance::destroy_zero<T0>(arg5);
        emit_swap_and_count(arg0, 16, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun dlmm_b2a<T0, T1>(arg0: &mut R, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg7);
        let v0 = 0x2::balance::value<T1>(&arg5);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg3, arg4, false, true, v0, arg1, arg2, arg6, arg7);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4)), v4, arg2);
        0x2::balance::destroy_zero<T1>(arg5);
        emit_swap_and_count(arg0, 16, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    fun emit_swap_and_count(arg0: &mut R, arg1: u8, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = SwapEvent{
            dex        : arg1,
            a2b        : arg2,
            amount_in  : arg3,
            amount_out : arg4,
        };
        0x2::event::emit<SwapEvent>(v0);
        arg0.total_swaps = arg0.total_swaps + 1;
    }

    public fun ferra_v3_a2b<T0, T1>(arg0: &mut R, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg2: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048016, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(arg3);
        emit_swap_and_count(arg0, 22, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun ferra_v3_b2a<T0, T1>(arg0: &mut R, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg2: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579055, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(arg3);
        emit_swap_and_count(arg0, 22, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun ferra_v4_a2b<T0, T1>(arg0: &mut R, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, true, 0, 0x2::coin::from_balance<T0>(arg3, arg5), 0x2::coin::zero<T1>(arg5), arg4, arg5);
        0x2::coin::destroy_zero<T0>(v0);
        let v2 = 0x2::coin::into_balance<T1>(v1);
        emit_swap_and_count(arg0, 23, true, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&v2));
        v2
    }

    public fun ferra_v4_b2a<T0, T1>(arg0: &mut R, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg1, arg2, false, 0, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(arg3, arg5), arg4, arg5);
        0x2::coin::destroy_zero<T1>(v1);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        emit_swap_and_count(arg0, 23, false, 0x2::balance::value<T1>(&arg3), 0x2::balance::value<T0>(&v2));
        v2
    }

    public fun flowx_v2_a2b<T0, T1>(arg0: &mut R, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg3);
        let v0 = 0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg3), arg3));
        emit_swap_and_count(arg0, 24, true, 0x2::balance::value<T0>(&arg2), 0x2::balance::value<T1>(&v0));
        v0
    }

    public fun flowx_v2_b2a<T0, T1>(arg0: &mut R, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg3);
        let v0 = 0x2::coin::into_balance<T0>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg3), arg3));
        emit_swap_and_count(arg0, 24, false, 0x2::balance::value<T1>(&arg2), 0x2::balance::value<T0>(&v0));
        v0
    }

    public fun flowx_v3_a2b<T0, T1>(arg0: &mut R, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg1, true, true, v0, 4295048016, arg2, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        let (v6, _) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T0>(v1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg1, v4, 0x2::balance::split<T0>(&mut arg3, v6), 0x2::balance::zero<T1>(), arg2, arg5);
        0x2::balance::destroy_zero<T0>(arg3);
        emit_swap_and_count(arg0, 25, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun flowx_v3_b2a<T0, T1>(arg0: &mut R, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(arg1, false, true, v0, 79226673515401279992447579055, arg2, arg4, arg5);
        let v4 = v3;
        let v5 = v1;
        let (_, v7) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T1>(v2);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v7), arg2, arg5);
        0x2::balance::destroy_zero<T1>(arg3);
        emit_swap_and_count(arg0, 25, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun grant_access(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.access_list, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        r_new(arg0);
    }

    public fun kriya_v2_a2b<T0, T1>(arg0: &mut R, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg3);
        let v0 = 0x2::coin::into_balance<T1>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg3), 0, 0, arg3));
        emit_swap_and_count(arg0, 26, true, 0x2::balance::value<T0>(&arg2), 0x2::balance::value<T1>(&v0));
        v0
    }

    public fun kriya_v2_b2a<T0, T1>(arg0: &mut R, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg3);
        let v0 = 0x2::coin::into_balance<T0>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg3), 0, 0, arg3));
        emit_swap_and_count(arg0, 26, false, 0x2::balance::value<T1>(&arg2), 0x2::balance::value<T0>(&v0));
        v0
    }

    public fun magma_a2b<T0, T1>(arg0: &mut R, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048016, arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::balance::destroy_zero<T0>(arg3);
        emit_swap_and_count(arg0, 20, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun magma_b2a<T0, T1>(arg0: &mut R, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579055, arg4);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::balance::destroy_zero<T1>(arg3);
        emit_swap_and_count(arg0, 20, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun migrate(arg0: &mut R, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    public fun momentum_a2b<T0, T1>(arg0: &mut R, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v0, 4295048016, arg4, arg2, arg5);
        let v4 = v3;
        let v5 = v2;
        let (v6, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T0>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::split<T0>(&mut arg3, v6), 0x2::balance::zero<T1>(), arg2, arg5);
        0x2::balance::destroy_zero<T0>(arg3);
        emit_swap_and_count(arg0, 21, true, v0, 0x2::balance::value<T1>(&v5));
        v5
    }

    public fun momentum_b2a<T0, T1>(arg0: &mut R, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v0, 79226673515401279992447579055, arg4, arg2, arg5);
        let v4 = v3;
        let v5 = v1;
        let (_, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        0x2::balance::destroy_zero<T1>(v2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v7), arg2, arg5);
        0x2::balance::destroy_zero<T1>(arg3);
        emit_swap_and_count(arg0, 21, false, v0, 0x2::balance::value<T0>(&v5));
        v5
    }

    public fun r_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = R{
            id           : 0x2::object::new(arg0),
            version      : 1,
            admin        : 0x2::tx_context::sender(arg0),
            access_list  : v0,
            total_swaps  : 0,
            total_profit : 0,
        };
        0x2::transfer::share_object<R>(v1);
    }

    public fun revoke_access(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.access_list, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.access_list, v1);
        };
    }

    public fun suiswap_a2b<T0, T1>(arg0: &mut R, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg4);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::from_balance<T0>(arg2, arg4));
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, v1, v0, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        let v4 = 0x2::coin::into_balance<T1>(v3);
        let v5 = SwapEvent{
            dex        : 11,
            a2b        : true,
            amount_in  : v0,
            amount_out : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<SwapEvent>(v5);
        arg0.total_swaps = arg0.total_swaps + 1;
        v4
    }

    public fun suiswap_b2a<T0, T1>(arg0: &mut R, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg4);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(arg2, arg4));
        let (v2, v3) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, v1, v0, arg3, arg4);
        0x2::coin::destroy_zero<T1>(v2);
        let v4 = 0x2::coin::into_balance<T0>(v3);
        let v5 = SwapEvent{
            dex        : 11,
            a2b        : false,
            amount_in  : v0,
            amount_out : 0x2::balance::value<T0>(&v4),
        };
        0x2::event::emit<SwapEvent>(v5);
        arg0.total_swaps = arg0.total_swaps + 1;
        v4
    }

    public fun total_profit(arg0: &R) : u64 {
        arg0.total_profit
    }

    public fun total_swaps(arg0: &R) : u64 {
        arg0.total_swaps
    }

    public fun transfer_admin(arg0: &mut R, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        admin_check(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &mut R, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, @0x0, true, (v0 as u128), true, 4295048016, arg4, arg2, arg5);
        0x2::coin::destroy_zero<T0>(v1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(arg3, arg5), 0x2::coin::zero<T1>(arg5), v3, arg2);
        let v4 = 0x2::coin::into_balance<T1>(v2);
        emit_swap_and_count(arg0, 17, true, v0, 0x2::balance::value<T1>(&v4));
        v4
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &mut R, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        access_check(arg0, arg5);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg1, @0x0, false, (v0 as u128), true, 79226673515401279992447579055, arg4, arg2, arg5);
        0x2::coin::destroy_zero<T1>(v2);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg1, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(arg3, arg5), v3, arg2);
        let v4 = 0x2::coin::into_balance<T0>(v1);
        emit_swap_and_count(arg0, 17, false, v0, 0x2::balance::value<T0>(&v4));
        v4
    }

    public fun xz(arg0: &mut R, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        access_check(arg0, arg4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg3, 2);
        let v1 = ProfitEvent{
            profit    : v0,
            recipient : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ProfitEvent>(v1);
        arg0.total_profit = arg0.total_profit + v0;
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2);
    }

    public fun xz_generic<T0>(arg0: &mut R, arg1: &mut 0x2::coin::Coin<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        access_check(arg0, arg4);
        assert!(0x2::balance::value<T0>(&arg2) >= arg3, 2);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

