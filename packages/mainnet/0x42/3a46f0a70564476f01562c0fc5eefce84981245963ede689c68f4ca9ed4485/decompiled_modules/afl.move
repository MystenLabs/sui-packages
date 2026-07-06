module 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::afl {
    public fun a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg6);
        let (v4, v5) = liquidate<T0, T1>(arg2, arg3, arg4, arg5, v0, arg7, arg8);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v4, arg7);
        0x2::balance::join<T0>(&mut v6, v8);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg8);
        transfer_or_destroy_balance<T1>(v7, arg8);
    }

    public fun a_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_a<T0, 0x2::sui::SUI>(arg0, arg1, arg7);
        let (v4, v5) = liquidate_sui<T0>(arg3, arg2, arg4, arg5, arg6, v0, arg8, arg9);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T0, 0x2::sui::SUI>(arg0, arg1, v4, arg8);
        0x2::balance::join<T0>(&mut v6, v8);
        repay_flash_a<T0, 0x2::sui::SUI>(arg0, arg1, v6, v1, v2, v3, arg9);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg9);
    }

    public fun b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg6);
        let (v4, v5) = liquidate<T0, T1>(arg2, arg3, arg4, arg5, v1, arg7, arg8);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v4, arg7);
        0x2::balance::join<T0>(&mut v6, v8);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg8);
        transfer_or_destroy_balance<T1>(v7, arg8);
    }

    public fun b_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_b<0x2::sui::SUI, T0>(arg0, arg1, arg7);
        let (v4, v5) = liquidate_sui<T0>(arg3, arg2, arg4, arg5, arg6, v1, arg8, arg9);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<0x2::sui::SUI, T0>(arg0, arg1, v4, arg8);
        0x2::balance::join<T0>(&mut v6, v8);
        repay_flash_b<0x2::sui::SUI, T0>(arg0, arg1, v0, v6, v2, v3, arg9);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg9);
    }

    public fun c<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg7);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, v0, arg8, arg9);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg2, v4, arg8);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v8, arg8);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg9);
        transfer_or_destroy_balance<T2>(v7, arg9);
        transfer_or_destroy_balance<T1>(v9, arg9);
    }

    public fun c_sui<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg8);
        let (v4, v5) = liquidate_sui<T0>(arg4, arg3, arg5, arg6, arg7, v0, arg9, arg10);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T1, 0x2::sui::SUI>(arg0, arg2, v4, arg9);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v8, arg9);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg10);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg10);
        transfer_or_destroy_balance<T1>(v9, arg10);
    }

    public fun d<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg7);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, v0, arg8, arg9);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg2, v4, arg8);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v8, arg8);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg9);
        transfer_or_destroy_balance<T2>(v7, arg9);
        transfer_or_destroy_balance<T1>(v9, arg9);
    }

    public fun d_sui<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_a<T0, T1>(arg0, arg1, arg8);
        let (v4, v5) = liquidate_sui<T0>(arg4, arg3, arg5, arg6, arg7, v0, arg9, arg10);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<0x2::sui::SUI, T1>(arg0, arg2, v4, arg9);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T0, T1>(arg0, arg1, v8, arg9);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_a<T0, T1>(arg0, arg1, v6, v1, v2, v3, arg10);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg10);
        transfer_or_destroy_balance<T1>(v9, arg10);
    }

    public fun e<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg7);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, v1, arg8, arg9);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg2, v4, arg8);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v8, arg8);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg9);
        transfer_or_destroy_balance<T2>(v7, arg9);
        transfer_or_destroy_balance<T1>(v9, arg9);
    }

    public fun e_sui<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg8);
        let (v4, v5) = liquidate_sui<T0>(arg4, arg3, arg5, arg6, arg7, v1, arg9, arg10);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_b_to_a<T1, 0x2::sui::SUI>(arg0, arg2, v4, arg9);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v8, arg9);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg10);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg10);
        transfer_or_destroy_balance<T1>(v9, arg10);
    }

    public fun f<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg7);
        let (v4, v5) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, v1, arg8, arg9);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg2, v4, arg8);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v8, arg8);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg9);
        transfer_or_destroy_balance<T2>(v7, arg9);
        transfer_or_destroy_balance<T1>(v9, arg9);
    }

    public fun f_sui<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::flash_loan_borrow_b<T1, T0>(arg0, arg1, arg8);
        let (v4, v5) = liquidate_sui<T0>(arg4, arg3, arg5, arg6, arg7, v1, arg9, arg10);
        let v6 = v5;
        let (v7, v8) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<0x2::sui::SUI, T1>(arg0, arg2, v4, arg9);
        let (v9, v10) = 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::swap_a_to_b<T1, T0>(arg0, arg1, v8, arg9);
        0x2::balance::join<T0>(&mut v6, v10);
        repay_flash_b<T1, T0>(arg0, arg1, v0, v6, v2, v3, arg10);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg10);
        transfer_or_destroy_balance<T1>(v9, arg10);
    }

    fun liquidate<T0, T1>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::al::l<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun liquidate_sui<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::al::l_sui<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun repay_flash_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg2) >= arg5, 1);
        0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, arg5), arg3, arg4);
        transfer_or_destroy_balance<T0>(arg2, arg6);
    }

    fun repay_flash_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashLoanReceipt, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg3) >= arg5, 1);
        0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::flash_adapters::repay_flash_loan<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut arg3, arg5), arg4);
        transfer_or_destroy_balance<T1>(arg3, arg6);
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), @0x4e64ed0c2a191ce5132488c80fa993715bacbe25eb4d035264d2adf3b9852c65);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

