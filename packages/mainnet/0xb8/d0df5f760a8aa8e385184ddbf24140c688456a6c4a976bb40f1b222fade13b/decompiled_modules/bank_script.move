module 0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::script_events::emit_event<0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::NeedsRebalance>(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

