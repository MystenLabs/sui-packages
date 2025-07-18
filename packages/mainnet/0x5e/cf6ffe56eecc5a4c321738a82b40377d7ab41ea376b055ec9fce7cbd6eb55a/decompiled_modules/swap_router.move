module 0x5ecf6ffe56eecc5a4c321738a82b40377d7ab41ea376b055ec9fce7cbd6eb55a::swap_router {
    fun cleanup_swap<T0, T1, T2, T3, T4>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            0x2::coin::join<T2>(arg4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T2, T4>(arg1, arg2, &mut arg6, 0x2::coin::value<T4>(&arg6), arg8, arg9));
        } else {
            0x2::coin::join<T1>(arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T1, T3>(arg0, arg2, &mut arg5, 0x2::coin::value<T3>(&arg5), arg8, arg9));
        };
        0x2::coin::destroy_zero<T3>(arg5);
        0x2::coin::destroy_zero<T4>(arg6);
    }

    public fun cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::CpQuoter, T5>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg6) {
            0x2::coin::value<T3>(&v3)
        } else {
            0x2::coin::value<T4>(&v2)
        };
        0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::swap<T3, T4, T5>(arg0, &mut v3, &mut v2, arg6, v4, 0, arg8);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, v3, v2, arg6, arg7, arg8);
    }

    public fun cpmm_swap_exact_x_to_y<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::Route, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::CpQuoter, T5>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg3: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::borrow_mut_current_path<T1, T2>(arg0);
        let v1 = 0x2::coin::zero<T2>(arg6);
        let v2 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::take_coin_in<T1, T2>(v0);
        let v3 = &mut v2;
        let v4 = &mut v1;
        cpmm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v3, v4, true, arg5, arg6);
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::utils::refund_if_necessary<T1>(v2, 0x2::tx_context::sender(arg6));
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::fill_coin_out<T1, T2>(v0, v1);
    }

    public fun cpmm_swap_exact_y_to_x<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::Route, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::CpQuoter, T5>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg3: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::borrow_mut_current_path<T2, T1>(arg0);
        let v1 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::take_coin_in<T2, T1>(v0);
        let v2 = 0x2::coin::zero<T1>(arg6);
        let v3 = &mut v2;
        let v4 = &mut v1;
        cpmm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v3, v4, false, arg5, arg6);
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::utils::refund_if_necessary<T2>(v1, 0x2::tx_context::sender(arg6));
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::fill_coin_out<T2, T1>(v0, v2);
    }

    public fun omm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::OracleQuoter, T5>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg8) {
            0x2::coin::value<T3>(&v3)
        } else {
            0x2::coin::value<T4>(&v2)
        };
        0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v3, &mut v2, arg8, v4, 0, arg9, arg10);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, v3, v2, arg8, arg9, arg10);
    }

    public fun omm_swap_exact_x_to_y<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::Route, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::OracleQuoter, T5>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg3: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::borrow_mut_current_path<T1, T2>(arg0);
        let v1 = 0x2::coin::zero<T2>(arg8);
        let v2 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::take_coin_in<T1, T2>(v0);
        let v3 = &mut v2;
        let v4 = &mut v1;
        omm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, v3, v4, true, arg7, arg8);
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::utils::refund_if_necessary<T1>(v2, 0x2::tx_context::sender(arg8));
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::fill_coin_out<T1, T2>(v0, v1);
    }

    public fun omm_swap_exact_y_to_x<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::Route, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::OracleQuoter, T5>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg3: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::borrow_mut_current_path<T2, T1>(arg0);
        let v1 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::take_coin_in<T2, T1>(v0);
        let v2 = 0x2::coin::zero<T1>(arg8);
        let v3 = &mut v2;
        let v4 = &mut v1;
        omm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, v3, v4, false, arg7, arg8);
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::utils::refund_if_necessary<T2>(v1, 0x2::tx_context::sender(arg8));
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::fill_coin_out<T2, T1>(v0, v2);
    }

    public fun omm_v2_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg8) {
            0x2::coin::value<T3>(&v3)
        } else {
            0x2::coin::value<T4>(&v2)
        };
        0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v3, &mut v2, arg8, v4, 0, arg9, arg10);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, v3, v2, arg8, arg9, arg10);
    }

    public fun omm_v2_swap_exact_x_to_y<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::Route, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg3: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::borrow_mut_current_path<T1, T2>(arg0);
        let v1 = 0x2::coin::zero<T2>(arg8);
        let v2 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::take_coin_in<T1, T2>(v0);
        let v3 = &mut v2;
        let v4 = &mut v1;
        omm_v2_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, v3, v4, true, arg7, arg8);
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::utils::refund_if_necessary<T1>(v2, 0x2::tx_context::sender(arg8));
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::fill_coin_out<T1, T2>(v0, v1);
    }

    public fun omm_v2_swap_exact_y_to_x<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::Route, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg3: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::borrow_mut_current_path<T2, T1>(arg0);
        let v1 = 0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::take_coin_in<T2, T1>(v0);
        let v2 = 0x2::coin::zero<T1>(arg8);
        let v3 = &mut v2;
        let v4 = &mut v1;
        omm_v2_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, v3, v4, false, arg7, arg8);
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::utils::refund_if_necessary<T2>(v1, 0x2::tx_context::sender(arg8));
        0xf48c8219250603549ca64e14d8d6a3c6a9b2ff3f1c2c1554e12b04b1f4fba2a8::universal_router::fill_coin_out<T2, T1>(v0, v2);
    }

    fun to_btokens<T0, T1, T2, T3, T4>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        let v0 = if (arg5) {
            0x2::coin::value<T1>(arg3)
        } else {
            0x2::coin::value<T2>(arg4)
        };
        if (arg5) {
            (0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::mint_btoken<T0, T1, T3>(arg0, arg2, arg3, v0, arg6, arg7), 0x2::coin::zero<T4>(arg7))
        } else {
            (0x2::coin::zero<T3>(arg7), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::mint_btoken<T0, T2, T4>(arg1, arg2, arg4, v0, arg6, arg7))
        }
    }

    // decompiled from Move bytecode v6
}

