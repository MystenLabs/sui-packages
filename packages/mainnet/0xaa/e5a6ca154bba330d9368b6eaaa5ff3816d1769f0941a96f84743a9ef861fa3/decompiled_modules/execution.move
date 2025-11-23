module 0xaae5a6ca154bba330d9368b6eaaa5ff3816d1769f0941a96f84743a9ef861fa3::execution {
    public fun calculate_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        0x2::clock::timestamp_ms(arg0) + arg1 * 60 * 1000
    }

    public fun execute_arbitrage<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>, arg2: u64, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xaae5a6ca154bba330d9368b6eaaa5ff3816d1769f0941a96f84743a9ef861fa3::deepbook_flashloan::first_swap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, arg2, arg3, arg4, arg8, arg10);
        let v3 = v1;
        let v4 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3);
        assert!(v4 > 0, 2);
        let v5 = 0x1::vector::empty<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>();
        0x1::vector::push_back<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut v5, v3);
        let v6 = 0xaae5a6ca154bba330d9368b6eaaa5ff3816d1769f0941a96f84743a9ef861fa3::deepbook_flashloan::second_swap<T0>(arg1, v5, v4, arg5, arg6, calculate_deadline(arg8, 10), arg8, arg9, v2, arg10);
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&v6);
        assert!(v7 >= arg2, 1);
        let (v8, v9) = if (v7 > arg2) {
            (0x2::coin::split<0x2::sui::SUI>(&mut v6, arg2, arg10), v6)
        } else {
            (v6, 0x2::coin::zero<0x2::sui::SUI>(arg10))
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, v8, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, arg6);
    }

    // decompiled from Move bytecode v6
}

