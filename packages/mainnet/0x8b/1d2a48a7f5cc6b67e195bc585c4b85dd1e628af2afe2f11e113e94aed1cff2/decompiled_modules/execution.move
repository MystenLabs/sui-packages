module 0x8b1d2a48a7f5cc6b67e195bc585c4b85dd1e628af2afe2f11e113e94aed1cff2::execution {
    public fun calculate_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        0x2::clock::timestamp_ms(arg0) + arg1 * 60 * 1000
    }

    public fun execute_arbitrage<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>, arg2: u64, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x8b1d2a48a7f5cc6b67e195bc585c4b85dd1e628af2afe2f11e113e94aed1cff2::deepbook_flashloan::first_swap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, arg2, arg3, 100, arg8, arg10);
        let v3 = v1;
        let v4 = if (arg2 > 1000000) {
            arg2 * 80 / 100
        } else {
            1000000
        };
        let v5 = 0x8b1d2a48a7f5cc6b67e195bc585c4b85dd1e628af2afe2f11e113e94aed1cff2::deepbook_flashloan::second_swap<T0>(arg1, v3, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3), v4, arg6, calculate_deadline(arg8, 10), arg8, arg9, v2, arg10);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        assert!(v6 >= arg2, 1);
        let (v7, v8) = if (v6 > arg2) {
            (0x2::coin::split<0x2::sui::SUI>(&mut v5, arg2, arg10), v5)
        } else {
            (v5, 0x2::coin::zero<0x2::sui::SUI>(arg10))
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, v7, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, arg6);
    }

    // decompiled from Move bytecode v6
}

