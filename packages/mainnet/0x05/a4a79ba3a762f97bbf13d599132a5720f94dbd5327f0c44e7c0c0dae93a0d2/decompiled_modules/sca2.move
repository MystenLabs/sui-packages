module 0x5a4a79ba3a762f97bbf13d599132a5720f94dbd5327f0c44e7c0c0dae93a0d2::sca2 {
    fun bcflda<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg2);
        0x2::balance::destroy_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg3), v2)
    }

    fun bcfldb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, false, arg2);
        0x2::balance::destroy_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg3), v2)
    }

    fun cflra<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::fee_rate_denominator() as u128);
        arg1 + ((((arg1 as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u128) + v0 - 1) / v0) as u64)
    }

    public fun lcfd2aa<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = bcflda<T0, T2>(arg5, arg7, arg8, arg10);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg9, arg10);
        rcfld2aa<T0, T1, T2>(arg5, arg6, arg7, arg8, v1, v2, v3, arg9, arg10);
    }

    public fun lcfd2ab<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = bcfldb<T2, T0>(arg5, arg7, arg8, arg10);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg9, arg10);
        rcfld2ab<T0, T1, T2>(arg5, arg6, arg7, arg8, v1, v2, v3, arg9, arg10);
    }

    public fun lcfd2ba<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = bcflda<T0, T2>(arg5, arg7, arg8, arg10);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg9, arg10);
        rcfld2ba<T0, T1, T2>(arg5, arg6, arg7, arg8, v1, v2, v3, arg9, arg10);
    }

    public fun lcfd2bb<T0, T1, T2>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = bcfldb<T2, T0>(arg5, arg7, arg8, arg10);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg9, arg10);
        rcfld2bb<T0, T1, T2>(arg5, arg6, arg7, arg8, v1, v2, v3, arg9, arg10);
    }

    public fun ldbcd2aa<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T3>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T3>(arg5, ss32aa<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    public fun ldbcd2ab<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T3>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T3>(arg5, ss32ab<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    public fun ldbcd2ba<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T3>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T3>(arg5, ss32ba<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    public fun ldbcd2bb<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T3>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T3>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T3>(arg5, ss32bb<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    public fun ldqcd2aa<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg5, ss32aa<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    public fun ldqcd2ab<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg5, ss32ab<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    public fun ldqcd2ba<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg5, ss32ba<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    public fun ldqcd2bb<T0, T1, T2, T3>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T3, T0>, arg6: u64, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T3, T0>(arg5, arg6, arg11);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg10, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T3, T0>(arg5, ss32bb<T0, T1, T2>(arg7, arg8, arg9, arg6, v2, v3, arg10, arg11), v1);
    }

    fun rcfld2aa<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = cflra<T0, T2>(arg2, arg3);
        let v1 = ss32aa<T0, T1, T2>(arg0, arg1, arg2, v0, arg5, arg6, arg7, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T2>(arg0, arg2, 0x2::coin::into_balance<T0>(v1), 0x2::balance::zero<T2>(), arg4);
    }

    fun rcfld2ab<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = cflra<T2, T0>(arg2, arg3);
        let v1 = ss32ab<T0, T1, T2>(arg0, arg1, arg2, v0, arg5, arg6, arg7, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T0>(v1), arg4);
    }

    fun rcfld2ba<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = cflra<T0, T2>(arg2, arg3);
        let v1 = ss32ba<T0, T1, T2>(arg0, arg1, arg2, v0, arg5, arg6, arg7, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T2>(arg0, arg2, 0x2::coin::into_balance<T0>(v1), 0x2::balance::zero<T2>(), arg4);
    }

    fun rcfld2bb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = cflra<T2, T0>(arg2, arg3);
        let v1 = ss32bb<T0, T1, T2>(arg0, arg1, arg2, v0, arg5, arg6, arg7, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T2, T0>(arg0, arg2, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T0>(v1), arg4);
    }

    fun ss32aa<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg4);
        if (v0 < arg3) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, false, false, arg3 - v0, 79226673515401279992447579055, arg6);
            let v4 = v3;
            0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v1, arg7));
            let v5 = 0x2::coin::from_balance<T2>(v2, arg7);
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v4);
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg1, true, false, v6, 4295048016, arg6);
            let v10 = v9;
            0x2::coin::join<T1>(&mut arg5, 0x2::coin::from_balance<T1>(v7, arg7));
            0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(v8, arg7));
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v10);
            assert!(0x2::coin::value<T1>(&arg5) >= v11, 101);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v11, arg7)), 0x2::balance::zero<T2>(), v10);
            assert!(0x2::coin::value<T2>(&v5) >= v6, 103);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v5, v6, arg7)), v4);
            0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T2>(v5, arg7);
        };
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 102);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T0>(arg4, arg7);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T1>(arg5, arg7);
        0x2::coin::split<T0>(&mut arg4, arg3, arg7)
    }

    fun ss32ab<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg4);
        if (v0 < arg3) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, true, false, arg3 - v0, 4295048016, arg6);
            let v4 = v3;
            let v5 = 0x2::coin::from_balance<T2>(v1, arg7);
            0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v2, arg7));
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v4);
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg0, arg1, true, false, v6, 4295048016, arg6);
            let v10 = v9;
            0x2::coin::join<T1>(&mut arg5, 0x2::coin::from_balance<T1>(v7, arg7));
            0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(v8, arg7));
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v10);
            assert!(0x2::coin::value<T1>(&arg5) >= v11, 101);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v11, arg7)), 0x2::balance::zero<T2>(), v10);
            assert!(0x2::coin::value<T2>(&v5) >= v6, 103);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v5, v6, arg7)), 0x2::balance::zero<T0>(), v4);
            0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T2>(v5, arg7);
        };
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 102);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T0>(arg4, arg7);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T1>(arg5, arg7);
        0x2::coin::split<T0>(&mut arg4, arg3, arg7)
    }

    fun ss32ba<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg4);
        if (v0 < arg3) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg0, arg2, false, false, arg3 - v0, 79226673515401279992447579055, arg6);
            let v4 = v3;
            0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v1, arg7));
            let v5 = 0x2::coin::from_balance<T2>(v2, arg7);
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v4);
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg1, false, false, v6, 79226673515401279992447579055, arg6);
            let v10 = v9;
            0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(v7, arg7));
            0x2::coin::join<T1>(&mut arg5, 0x2::coin::from_balance<T1>(v8, arg7));
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v10);
            assert!(0x2::coin::value<T1>(&arg5) >= v11, 101);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v11, arg7)), v10);
            assert!(0x2::coin::value<T2>(&v5) >= v6, 103);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v5, v6, arg7)), v4);
            0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T2>(v5, arg7);
        };
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 102);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T0>(arg4, arg7);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T1>(arg5, arg7);
        0x2::coin::split<T0>(&mut arg4, arg3, arg7)
    }

    fun ss32bb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg4);
        if (v0 < arg3) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg0, arg2, true, false, arg3 - v0, 4295048016, arg6);
            let v4 = v3;
            let v5 = 0x2::coin::from_balance<T2>(v1, arg7);
            0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v2, arg7));
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v4);
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg0, arg1, false, false, v6, 79226673515401279992447579055, arg6);
            let v10 = v9;
            0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(v7, arg7));
            0x2::coin::join<T1>(&mut arg5, 0x2::coin::from_balance<T1>(v8, arg7));
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v10);
            assert!(0x2::coin::value<T1>(&arg5) >= v11, 101);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg0, arg1, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v11, arg7)), v10);
            assert!(0x2::coin::value<T2>(&v5) >= v6, 103);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg0, arg2, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v5, v6, arg7)), 0x2::balance::zero<T0>(), v4);
            0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T2>(v5, arg7);
        };
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 102);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T0>(arg4, arg7);
        0xb8aab8db105e513a2796153ad7291e7ab3dec2fda8e9c2ea1d6360777905830f::vv::tdc<T1>(arg5, arg7);
        0x2::coin::split<T0>(&mut arg4, arg3, arg7)
    }

    // decompiled from Move bytecode v6
}

