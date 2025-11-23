module 0xd3bdac92e76747afe51a6067f917a633413ab5594958c3bb949783ce41fa44f::execution {
    public fun calculate_deadline(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        0x2::clock::timestamp_ms(arg0) + arg1 * 60 * 1000
    }

    public fun execute_arbitrage<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>, arg2: u64, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xd3bdac92e76747afe51a6067f917a633413ab5594958c3bb949783ce41fa44f::deepbook_flashloan::first_swap(arg0, arg2, arg3, arg4, arg8, arg10);
        let v3 = v1;
        let v4 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3);
        assert!(v4 > 0, 2);
        let v5 = if (arg5 > arg2 * 50 / 100) {
            arg2 * 50 / 100
        } else {
            arg5
        };
        let v6 = 0x1::vector::empty<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>();
        0x1::vector::push_back<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut v6, v3);
        let v7 = 0xd3bdac92e76747afe51a6067f917a633413ab5594958c3bb949783ce41fa44f::deepbook_flashloan::second_swap<T0>(arg1, v6, v4, v5, arg6, calculate_deadline(arg8, 10), arg8, arg9, v2, arg10);
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&v7);
        assert!(v8 >= arg2, 1);
        let (v9, v10) = if (v8 > arg2) {
            (0x2::coin::split<0x2::sui::SUI>(&mut v7, arg2, arg10), v7)
        } else {
            (v7, 0x2::coin::zero<0x2::sui::SUI>(arg10))
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI>(arg0, v9, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, arg6);
    }

    // decompiled from Move bytecode v6
}

