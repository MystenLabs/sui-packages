module 0x39d7e5fecd237d61764cbd714355faaf8de16afe914339a619b09e9e35c6c557::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T0>(arg0, arg4);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T1>(arg0, 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::swap_router::swap_exact_x_to_y<T0, T1>(arg1, 0x2::coin::from_balance<T0>(v0, arg5), 4295048017, arg2, arg3, arg5));
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T1>(arg0, arg4);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T0>(arg0, 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::swap_router::swap_exact_y_to_x<T0, T1>(arg1, 0x2::coin::from_balance<T1>(v0, arg5), 79226673515401279992447579054, arg2, arg3, arg5));
    }

    // decompiled from Move bytecode v7
}

