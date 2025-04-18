module 0xa4544b52b40e44e41d3ec2d13a9b112b6d0b199641ba98b4664da2f841168ce5::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::bank::Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        0xa4544b52b40e44e41d3ec2d13a9b112b6d0b199641ba98b4664da2f841168ce5::script_events::emit_event<0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::bank::NeedsRebalance>(0xb41402e33ca9c00b610ae96a0780de7ba0caaa10f50b11b8d54ad6f1f4e50ce5::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

