module 0xb499e8870a75daf165ef70ea3876150cdcd964ca650a4fd0d6a30f944adc1848::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>, arg2: &0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Config, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>, arg2: &0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Config, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T0>(arg0, arg4);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T1>(arg0, 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::swap_a_for_b<T0, T1>(arg1, arg2, v0, 0, arg3, arg5));
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Pool<T0, T1>, arg2: &0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::Config, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T1>(arg0, arg4);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T0>(arg0, 0x5f51d02fa049194239ffeac3e446a0020e7bbfc5d9149ff888366c24b2456b1::SRMV1::swap_b_for_a<T0, T1>(arg1, arg2, v0, 0, arg3, arg5));
    }

    // decompiled from Move bytecode v7
}

