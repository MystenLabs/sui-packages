module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::flash_arb {
    struct HotArbExecutedV1<phantom T0, phantom T1> has copy, drop {
        sender: address,
        route_family: u8,
        reverse: bool,
        quote_loan: bool,
        loan_pool: 0x2::object::ID,
        venue_one: 0x2::object::ID,
        venue_two: 0x2::object::ID,
        amount: u64,
        leg_one_output: u64,
        final_output: u64,
        realized_profit: u64,
        min_profit: u64,
        min_leg_one_output: u64,
        min_final_output: u64,
        deadline_ms: u64,
    }

    fun assert_leg_one<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 >= arg1, 103);
        v0
    }

    fun assert_leg_two<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 >= arg1, 104);
        v0
    }

    public fun cetus_flowx_amm_base_v1<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        validate_request(arg4, arg5, arg7, arg9, arg10);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1);
        let v1 = 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_base<T0, T2>(arg0, arg5, arg11);
        let (v3, v4, v5) = route_cetus_flowx_amm<T0, T1>(arg1, arg2, arg3, arg4, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg6, arg8, arg9, arg11);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_base<T0, T2>(arg0, v3, v2, arg11), 3, arg6, false, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>>(arg0), v0, v1, arg5, v4, v5, arg7, arg8, arg9, arg10, arg11);
    }

    public fun cetus_flowx_amm_quote_v1<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        validate_request(arg4, arg5, arg7, arg9, arg10);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1);
        let v1 = 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_quote<T2, T0>(arg0, arg5, arg11);
        let (v3, v4, v5) = route_cetus_flowx_amm<T0, T1>(arg1, arg2, arg3, arg4, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg6, arg8, arg9, arg11);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_quote<T2, T0>(arg0, v3, v2, arg11), 3, arg6, true, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg0), v0, v1, arg5, v4, v5, arg7, arg8, arg9, arg10, arg11);
    }

    public fun cetus_kriya_amm_base_v1<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        validate_request(arg4, arg5, arg7, arg9, arg10);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1);
        let v1 = 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_base<T0, T2>(arg0, arg5, arg11);
        let (v3, v4, v5) = route_cetus_kriya_amm<T0, T1>(arg1, arg2, arg3, arg4, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg6, arg8, arg9, arg11);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_base<T0, T2>(arg0, v3, v2, arg11), 1, arg6, false, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>>(arg0), v0, v1, arg5, v4, v5, arg7, arg8, arg9, arg10, arg11);
    }

    public fun cetus_kriya_amm_quote_v1<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        validate_request(arg4, arg5, arg7, arg9, arg10);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1);
        let v1 = 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_quote<T2, T0>(arg0, arg5, arg11);
        let (v3, v4, v5) = route_cetus_kriya_amm<T0, T1>(arg1, arg2, arg3, arg4, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg6, arg8, arg9, arg11);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_quote<T2, T0>(arg0, v3, v2, arg11), 1, arg6, true, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg0), v0, v1, arg5, v4, v5, arg7, arg8, arg9, arg10, arg11);
    }

    public fun cetus_kriya_clmm_base_v1<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        validate_request(arg5, arg6, arg8, arg10, arg11);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1);
        let v1 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_base<T0, T2>(arg0, arg6, arg12);
        let (v3, v4, v5) = route_cetus_kriya_clmm<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg7, arg9, arg10, arg12);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_base<T0, T2>(arg0, v3, v2, arg12), 2, arg7, false, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>>(arg0), v0, v1, arg6, v4, v5, arg8, arg9, arg10, arg11, arg12);
    }

    public fun cetus_kriya_clmm_quote_v1<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        validate_request(arg5, arg6, arg8, arg10, arg11);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1);
        let v1 = 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_quote<T2, T0>(arg0, arg6, arg12);
        let (v3, v4, v5) = route_cetus_kriya_clmm<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg7, arg9, arg10, arg12);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_quote<T2, T0>(arg0, v3, v2, arg12), 2, arg7, true, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T0>>(arg0), v0, v1, arg6, v4, v5, arg8, arg9, arg10, arg11, arg12);
    }

    fun route_cetus_flowx_amm<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, u64) {
        if (!arg5) {
            let v3 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_b_a<T1, T0>(arg3, arg2, arg0, arg4, arg8);
            let v4 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::fx_a<T1, T0>(arg1, v3, arg8);
            (v4, assert_leg_one<T1>(&v3, arg6), assert_leg_two<T0>(&v4, arg7))
        } else {
            let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::fx_b<T1, T0>(arg1, arg4, arg8);
            let v6 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_a_b<T1, T0>(arg3, arg2, arg0, v5, arg8);
            (v6, assert_leg_one<T1>(&v5, arg6), assert_leg_two<T0>(&v6, arg7))
        }
    }

    fun route_cetus_kriya_amm<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, u64) {
        if (!arg5) {
            let v3 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_b_a<T1, T0>(arg3, arg2, arg0, arg4, arg8);
            let v4 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kr_a<T1, T0>(arg1, v3, arg8);
            (v4, assert_leg_one<T1>(&v3, arg6), assert_leg_two<T0>(&v4, arg7))
        } else {
            let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kr_b<T1, T0>(arg1, arg4, arg8);
            let v6 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_a_b<T1, T0>(arg3, arg2, arg0, v5, arg8);
            (v6, assert_leg_one<T1>(&v5, arg6), assert_leg_two<T0>(&v6, arg7))
        }
    }

    fun route_cetus_kriya_clmm<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T0>, arg6: bool, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, u64) {
        if (!arg6) {
            let v3 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_b_a<T1, T0>(arg4, arg2, arg0, arg5, arg9);
            let v4 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kc_a<T1, T0>(arg4, arg3, arg1, v3, arg9);
            (v4, assert_leg_one<T1>(&v3, arg7), assert_leg_two<T0>(&v4, arg8))
        } else {
            let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kc_b<T1, T0>(arg4, arg3, arg1, arg5, arg9);
            let v6 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_a_b<T1, T0>(arg4, arg2, arg0, v5, arg9);
            (v6, assert_leg_one<T1>(&v5, arg7), assert_leg_two<T0>(&v6, arg8))
        }
    }

    fun route_turbos_bluefin<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T0>, arg6: bool, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, u64) {
        if (!arg6) {
            let v3 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_b<T1, T0, T2>(arg0, arg5, arg4, arg2, arg9);
            let v4 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::bf_a<T1, T0>(arg4, arg3, arg1, v3, arg9);
            (v4, assert_leg_one<T1>(&v3, arg7), assert_leg_two<T0>(&v4, arg8))
        } else {
            let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::bf_b<T1, T0>(arg4, arg3, arg1, arg5, arg9);
            let v6 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_a<T1, T0, T2>(arg0, v5, arg4, arg2, arg9);
            (v6, assert_leg_one<T1>(&v5, arg7), assert_leg_two<T0>(&v6, arg8))
        }
    }

    fun route_turbos_flowx_clmm<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T0>, arg7: bool, arg8: u128, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, u64) {
        if (!arg7) {
            let v3 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_b<T1, T0, T2>(arg0, arg6, arg5, arg4, arg11);
            let v4 = 0x2::coin::into_balance<T0>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flowx_clmm_a2b<T1, T0>(arg1, arg2, arg3, arg5, 0x2::coin::from_balance<T1>(v3, arg11), arg8, arg11));
            (v4, assert_leg_one<T1>(&v3, arg9), assert_leg_two<T0>(&v4, arg10))
        } else {
            let v5 = 0x2::coin::into_balance<T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flowx_clmm_b2a<T1, T0>(arg1, arg2, arg3, arg5, 0x2::coin::from_balance<T0>(arg6, arg11), arg8, arg11));
            let v6 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_a<T1, T0, T2>(arg0, v5, arg5, arg4, arg11);
            (v6, assert_leg_one<T1>(&v5, arg9), assert_leg_two<T0>(&v6, arg10))
        }
    }

    fun route_turbos_kriya_amm<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, u64) {
        if (!arg5) {
            let v3 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_b<T1, T0, T2>(arg0, arg4, arg3, arg2, arg8);
            let v4 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kr_a<T1, T0>(arg1, v3, arg8);
            (v4, assert_leg_one<T1>(&v3, arg6), assert_leg_two<T0>(&v4, arg7))
        } else {
            let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::kr_b<T1, T0>(arg1, arg4, arg8);
            let v6 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::turbos_a<T1, T0, T2>(arg0, v5, arg3, arg2, arg8);
            (v6, assert_leg_one<T1>(&v5, arg6), assert_leg_two<T0>(&v6, arg7))
        }
    }

    fun settle<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u8, arg2: bool, arg3: bool, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg10, 106);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = HotArbExecutedV1<T0, T1>{
            sender             : v1,
            route_family       : arg1,
            reverse            : arg2,
            quote_loan         : arg3,
            loan_pool          : arg4,
            venue_one          : arg5,
            venue_two          : arg6,
            amount             : arg7,
            leg_one_output     : arg8,
            final_output       : arg9,
            realized_profit    : v0,
            min_profit         : arg10,
            min_leg_one_output : arg11,
            min_final_output   : arg12,
            deadline_ms        : arg13,
        };
        0x2::event::emit<HotArbExecutedV1<T0, T1>>(v2);
        0x2::balance::send_funds<T0>(arg0, v1);
    }

    public fun turbos_bluefin_base_v1<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        validate_request(arg5, arg6, arg8, arg10, arg11);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg1);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_base<T0, T3>(arg0, arg6, arg12);
        let (v3, v4, v5) = route_turbos_bluefin<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg7, arg9, arg10, arg12);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_base<T0, T3>(arg0, v3, v2, arg12), 5, arg7, false, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>>(arg0), v0, v1, arg6, v4, v5, arg8, arg9, arg10, arg11, arg12);
    }

    public fun turbos_bluefin_quote_v1<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        validate_request(arg5, arg6, arg8, arg10, arg11);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg1);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_quote<T3, T0>(arg0, arg6, arg12);
        let (v3, v4, v5) = route_turbos_bluefin<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg7, arg9, arg10, arg12);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_quote<T3, T0>(arg0, v3, v2, arg12), 5, arg7, true, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>>(arg0), v0, v1, arg6, v4, v5, arg8, arg9, arg10, arg11, arg12);
    }

    public fun turbos_flowx_clmm_base_v1<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        validate_request(arg6, arg7, arg10, arg12, arg13);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg1);
        let v1 = 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_base<T0, T3>(arg0, arg7, arg14);
        let (v3, v4, v5) = route_turbos_flowx_clmm<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg8, arg9, arg11, arg12, arg14);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_base<T0, T3>(arg0, v3, v2, arg14), 4, arg8, false, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>>(arg0), v0, v1, arg7, v4, v5, arg10, arg11, arg12, arg13, arg14);
    }

    public fun turbos_flowx_clmm_quote_v1<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: u64, arg8: bool, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        validate_request(arg6, arg7, arg10, arg12, arg13);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg1);
        let v1 = 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_quote<T3, T0>(arg0, arg7, arg14);
        let (v3, v4, v5) = route_turbos_flowx_clmm<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg8, arg9, arg11, arg12, arg14);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_quote<T3, T0>(arg0, v3, v2, arg14), 4, arg8, true, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>>(arg0), v0, v1, arg7, v4, v5, arg10, arg11, arg12, arg13, arg14);
    }

    public fun turbos_kriya_amm_base_v1<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        validate_request(arg4, arg5, arg7, arg9, arg10);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg1);
        let v1 = 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_base<T0, T3>(arg0, arg5, arg11);
        let (v3, v4, v5) = route_turbos_kriya_amm<T0, T1, T2>(arg1, arg2, arg3, arg4, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg6, arg8, arg9, arg11);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_base<T0, T3>(arg0, v3, v2, arg11), 6, arg6, false, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>>(arg0), v0, v1, arg5, v4, v5, arg7, arg8, arg9, arg10, arg11);
    }

    public fun turbos_kriya_amm_quote_v1<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        validate_request(arg4, arg5, arg7, arg9, arg10);
        let v0 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T0, T2>>(arg1);
        let v1 = 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T0>>(arg2);
        let v2 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_quote<T3, T0>(arg0, arg5, arg11);
        let (v3, v4, v5) = route_turbos_kriya_amm<T0, T1, T2>(arg1, arg2, arg3, arg4, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v2), arg6, arg8, arg9, arg11);
        settle<T0, T1>(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_quote<T3, T0>(arg0, v3, v2, arg11), 6, arg6, true, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>>(arg0), v0, v1, arg5, v4, v5, arg7, arg8, arg9, arg10, arg11);
    }

    fun validate_request(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        validate_request_at(0x2::clock::timestamp_ms(arg0), arg1, arg2, arg3, arg4);
    }

    fun validate_request_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 > 0, 100);
        assert!(arg3 >= arg1 + arg2, 105);
        assert!(arg0 <= arg4, 101);
        assert!(arg4 - arg0 <= 30000, 102);
    }

    // decompiled from Move bytecode v7
}

