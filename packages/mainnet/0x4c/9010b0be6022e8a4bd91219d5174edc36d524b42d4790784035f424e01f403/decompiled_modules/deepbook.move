module 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::deepbook {
    public(friend) fun base_to_quote<T0, T1>(arg0: &mut 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::Control, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::policies::borrow_mut<0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::SwapPolicy<T0, T1>>(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::policies_mut(arg0));
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), arg3, arg4, arg5);
        let v5 = v3;
        let v6 = v2;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::finish<T0, T1>(v1, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::begin<T0, T1>(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1), v0, arg4), 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::controller(arg0), v0 - 0x2::coin::value<T0>(&v6), 0x2::coin::value<T1>(&v5), arg3);
        (0x2::coin::into_balance<T0>(v6), 0x2::coin::into_balance<T1>(v5))
    }

    public(friend) fun quote_to_base<T0, T1>(arg0: &mut 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::Control, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::policies::borrow_mut<0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::SwapPolicy<T1, T0>>(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::policies_mut(arg0));
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), arg3, arg4, arg5);
        let v5 = v3;
        let v6 = v2;
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::finish<T1, T0>(v1, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::swap_policy::begin<T1, T0>(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1), v0, arg4), 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::controller(arg0), v0 - 0x2::coin::value<T1>(&v5), 0x2::coin::value<T0>(&v6), arg3);
        (0x2::coin::into_balance<T0>(v6), 0x2::coin::into_balance<T1>(v5))
    }

    // decompiled from Move bytecode v7
}

