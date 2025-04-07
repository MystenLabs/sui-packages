module 0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::script_events::emit_event<0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::NeedsRebalance>(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

