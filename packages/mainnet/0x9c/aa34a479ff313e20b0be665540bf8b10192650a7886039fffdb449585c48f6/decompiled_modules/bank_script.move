module 0xdfcac0610e134d98885744e0fb4b400c77b850abaf7ec4b372530e3661d9728e::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0xddaa7c8c1e74d4b0448c5a11fdbee779eaca26c40183d8791e315c8f62530d51::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        0xdfcac0610e134d98885744e0fb4b400c77b850abaf7ec4b372530e3661d9728e::script_events::emit_event<0xddaa7c8c1e74d4b0448c5a11fdbee779eaca26c40183d8791e315c8f62530d51::bank::NeedsRebalance>(0xddaa7c8c1e74d4b0448c5a11fdbee779eaca26c40183d8791e315c8f62530d51::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

