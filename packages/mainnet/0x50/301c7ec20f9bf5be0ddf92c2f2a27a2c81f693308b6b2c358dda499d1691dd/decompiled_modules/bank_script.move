module 0x50301c7ec20f9bf5be0ddf92c2f2a27a2c81f693308b6b2c358dda499d1691dd::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        0x50301c7ec20f9bf5be0ddf92c2f2a27a2c81f693308b6b2c358dda499d1691dd::script_events::emit_event<0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::NeedsRebalance>(0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

