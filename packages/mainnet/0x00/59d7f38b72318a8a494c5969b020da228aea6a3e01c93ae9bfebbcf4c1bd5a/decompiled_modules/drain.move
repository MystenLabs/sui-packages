module 0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::drain {
    public fun run<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::protocol_fee::ProtocolFeeConfig, arg5: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::treasury::Treasury, arg6: &mut 0xd89f1462232cadbf86e4e306ee6f28d6ccfd40913c6702aaa66fbb52e4573552::router::DeepBookV3RouterWrapper, arg7: &0x2::clock::Clock, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 >= 1 && arg8 <= 8, 0);
        assert!(arg9 >= 1 && arg8 <= arg12 / arg9, 1);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg12, arg13);
        let v2 = v0;
        let v3 = 0x2::balance::zero<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>();
        let v4 = 0;
        while (v4 < arg8) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg2, arg3, v4 + 1, 0, 0, arg10, arg11, false, false, 4102444800000, arg7, arg13);
            let v5 = 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::begin_router_tx_r1_w1_varied_in<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v2, arg9, arg13), arg9, 0, 0, arg4, arg5, @0x0, 0, arg13);
            let v6 = 0x2::balance::zero<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>();
            0x2::balance::join<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>(&mut v6, 0xd89f1462232cadbf86e4e306ee6f28d6ccfd40913c6702aaa66fbb52e4573552::router::swap_exact_quote_for_base_deep_w1<0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterDataV1, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6, &mut v5, arg0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::initiate_path_w1<0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterDataV1, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v5, arg9), arg7, arg13));
            0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::end_router_tx_r1_w1<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>(v5, &mut v6, arg13);
            0x2::balance::join<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>(&mut v3, v6);
            v4 = v4 + 1;
        };
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg13);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v7, v2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v7, arg12, arg13), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v7, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>>(0x2::coin::from_balance<0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk::JUNK>(v3, arg13), 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v7
}

