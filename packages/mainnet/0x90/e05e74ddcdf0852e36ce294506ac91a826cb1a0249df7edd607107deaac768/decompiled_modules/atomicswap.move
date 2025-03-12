module 0x90e05e74ddcdf0852e36ce294506ac91a826cb1a0249df7edd607107deaac768::atomicswap {
    struct GlobalConfig has copy, drop, store {
        dummy: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        dummy: bool,
    }

    public fun swap<T0, T1>(arg0: address, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg10));
    }

    public entry fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::zero<T0>(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun atomic_swap_b2a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T1>(arg2, arg4, arg8);
        swap_b2a<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun swap_b2a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(@0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, arg0, arg1, arg2, false, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

