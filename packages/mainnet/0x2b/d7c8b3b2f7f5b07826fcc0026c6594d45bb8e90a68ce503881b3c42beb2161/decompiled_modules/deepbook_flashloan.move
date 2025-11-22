module 0x2bd7c8b3b2f7f5b07826fcc0026c6594d45bb8e90a68ce503881b3c42beb2161::deepbook_flashloan {
    public fun first_swap<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg5);
        let (v2, v3) = 0x2bd7c8b3b2f7f5b07826fcc0026c6594d45bb8e90a68ce503881b3c42beb2161::deepbook_swap::swap_sui_to_deep<T0, T1>(arg0, v0, arg2, arg3, arg4, arg5);
        (v1, v2, v3)
    }

    public fun return_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, arg1, arg2);
    }

    public fun second_swap<T0>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>();
        0x1::vector::push_back<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(&mut v0, arg1);
        let (v1, v2) = 0x2bd7c8b3b2f7f5b07826fcc0026c6594d45bb8e90a68ce503881b3c42beb2161::swap_turbos::swap_a_to_b<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0x2::sui::SUI, T0>(arg0, v0, arg2, arg3, 0, true, arg4, arg5, arg6, arg7, arg9);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v2, 0x2::tx_context::sender(arg9));
        0x2::coin::join<0x2::sui::SUI>(&mut v3, arg8);
        v3
    }

    // decompiled from Move bytecode v6
}

