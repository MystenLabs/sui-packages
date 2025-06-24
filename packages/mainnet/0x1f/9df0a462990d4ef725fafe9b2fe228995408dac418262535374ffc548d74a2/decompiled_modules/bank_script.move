module 0x1f9df0a462990d4ef725fafe9b2fe228995408dac418262535374ffc548d74a2::bank_script {
    public fun needs_rebalance<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        0x1f9df0a462990d4ef725fafe9b2fe228995408dac418262535374ffc548d74a2::script_events::emit_event<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::NeedsRebalance>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::needs_rebalance<T0, T1, T2>(arg0, arg1, arg2));
    }

    // decompiled from Move bytecode v6
}

