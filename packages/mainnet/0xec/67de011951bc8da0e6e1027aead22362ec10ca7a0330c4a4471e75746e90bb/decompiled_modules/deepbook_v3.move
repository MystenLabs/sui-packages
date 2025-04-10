module 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::deepbook_v3 {
    struct SEvent has copy, drop {
        amount: u64,
        dp: u64,
        in: u64,
        out: u64,
        a: u64,
        b: u64,
        dp_return: u64,
        coin_in: u64,
        used: u64,
        taker_fee: u64,
        fee: u64,
    }

    public fun dp_swap_ab<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::Vault, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64, u64) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg7));
        let v0 = 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::merge_all<T0>(arg3, arg7);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg2, arg4, arg6);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::coin::split<T0>(&mut v0, arg4, arg7), 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::use_<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v3, arg7), 0, arg6, arg7);
        let v7 = v5;
        0x2::coin::join<T0>(&mut v0, v4);
        let v8 = 0x2::coin::value<T0>(&v0) - 0x2::coin::value<T0>(&v0);
        let (v9, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg2);
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::transfer<T0>(v0, 0x2::tx_context::sender(arg7));
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::back_<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v6);
        (v7, v8 + v8 * v9 / 1000000000, 0x2::coin::value<T1>(&v7))
    }

    public fun dp_swap_ab1<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::Vault, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64, u64) {
        let (v0, v1, v2) = dp_swap_ab<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v3, v0);
        (v3, v1, v2)
    }

    public fun dp_swap_ba<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::Vault, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg7));
        let v0 = 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::merge_all<T1>(arg3, arg7);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg2, arg4, arg6);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, 0x2::coin::split<T1>(&mut v0, arg4, arg7), 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::use_<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v3, arg7), 0, arg6, arg7);
        let v7 = v4;
        0x2::coin::join<T1>(&mut v0, v5);
        let v8 = 0x2::coin::value<T1>(&v0) - 0x2::coin::value<T1>(&v0);
        let (v9, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg2);
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::transfer<T1>(v0, 0x2::tx_context::sender(arg7));
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::back_<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v6);
        (v7, v8 + v8 * v9 / 1000000000, 0x2::coin::value<T0>(&v7))
    }

    public fun dp_swap_ba1<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault::Vault, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64, u64) {
        let (v0, v1, v2) = dp_swap_ba<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, v0);
        (v3, v1, v2)
    }

    // decompiled from Move bytecode v6
}

