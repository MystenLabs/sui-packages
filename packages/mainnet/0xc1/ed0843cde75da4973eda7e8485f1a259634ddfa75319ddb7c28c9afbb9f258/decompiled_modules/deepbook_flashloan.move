module 0xc1ed0843cde75da4973eda7e8485f1a259634ddfa75319ddb7c28c9afbb9f258::deepbook_flashloan {
    public fun first_swap<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg5);
        let (v2, v3) = 0xc1ed0843cde75da4973eda7e8485f1a259634ddfa75319ddb7c28c9afbb9f258::deepbook_swap::swap_sui_to_deep<T0, T1>(arg0, v0, arg2, arg3, arg4, arg5);
        (v1, v2, v3)
    }

    public fun second_swap<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>, arg1: vector<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = 0xc1ed0843cde75da4973eda7e8485f1a259634ddfa75319ddb7c28c9afbb9f258::swap_turbos::swap_a_to_b<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3, 0, true, arg4, arg5, arg6, arg7, arg9);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v1, 0x2::tx_context::sender(arg9));
        0x2::coin::join<0x2::sui::SUI>(&mut v2, arg8);
        v2
    }

    // decompiled from Move bytecode v6
}

