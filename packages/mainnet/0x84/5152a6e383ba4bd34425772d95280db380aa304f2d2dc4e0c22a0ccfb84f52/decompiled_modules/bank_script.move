module 0x845152a6e383ba4bd34425772d95280db380aa304f2d2dc4e0c22a0ccfb84f52::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        0x845152a6e383ba4bd34425772d95280db380aa304f2d2dc4e0c22a0ccfb84f52::script_events::emit_event<0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::bank::NeedsRebalance>(0x8f19f70c0ce1f69c5533e1e981b5b0342b309cb1d324ee6b0d5e9b969d1cc639::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

