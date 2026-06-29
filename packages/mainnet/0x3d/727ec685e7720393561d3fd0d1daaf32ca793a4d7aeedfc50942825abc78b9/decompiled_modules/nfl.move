module 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::nfl {
    public fun a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg13);
        let (v4, v5) = liquidate<T0, T1>(arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
        let v6 = v5;
        let (v7, v8) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v4, arg2);
        0x2::balance::join<T0>(&mut v6, v8);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg14);
        transfer_or_destroy_balance<T1>(v7, arg14);
    }

    public fun b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg13);
        let (v4, v5) = liquidate<T0, T1>(arg2, arg3, arg4, arg5, arg6, v1, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
        let v6 = v5;
        let (v7, v8) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v4, arg2);
        0x2::balance::join<T0>(&mut v6, v8);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg14);
        transfer_or_destroy_balance<T1>(v7, arg14);
    }

    public fun c<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg14);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        let v6 = v5;
        let (v7, v8) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg2, v4, arg3);
        let (v9, v10) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v8, arg3);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg15);
        transfer_or_destroy_balance<T2>(v7, arg15);
        transfer_or_destroy_balance<T1>(v9, arg15);
    }

    public fun d<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg14);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        let v6 = v5;
        let (v7, v8) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg2, v4, arg3);
        let (v9, v10) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v8, arg3);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg15);
        transfer_or_destroy_balance<T2>(v7, arg15);
        transfer_or_destroy_balance<T1>(v9, arg15);
    }

    public fun e<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg14);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v1, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        let v6 = v5;
        let (v7, v8) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg2, v4, arg3);
        let (v9, v10) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v8, arg3);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg15);
        transfer_or_destroy_balance<T2>(v7, arg15);
        transfer_or_destroy_balance<T1>(v9, arg15);
    }

    public fun f<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg14);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v1, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        let v6 = v5;
        let (v7, v8) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg2, v4, arg3);
        let (v9, v10) = 0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v8, arg3);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg15);
        transfer_or_destroy_balance<T2>(v7, arg15);
        transfer_or_destroy_balance<T1>(v9, arg15);
    }

    fun liquidate<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::nl::l<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    fun repay_flash_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg2) >= arg5, 1);
        0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, arg5), arg3, arg4);
        transfer_or_destroy_balance<T0>(arg2, arg6);
    }

    fun repay_flash_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg3) >= arg5, 1);
        0x3d727ec685e7720393561d3fd0d1daaf32ca793a4d7aeedfc50942825abc78b9::flash_adapters::repay_flash_loan<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut arg3, arg5), arg4);
        transfer_or_destroy_balance<T1>(arg3, arg6);
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), @0x25b17d20d25caa33e3185b9d9bf9f7895a6c1e0356f45ca2cb67a518cad59494);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

