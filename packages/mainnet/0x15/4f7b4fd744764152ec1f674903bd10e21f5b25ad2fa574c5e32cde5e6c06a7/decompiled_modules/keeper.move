module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::keeper {
    public entry fun activate_and_go_live<T0, T1>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::status(arg0) == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_cranking(), 100);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::activation_time(arg0), 103);
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::mark_live(arg0, arg1, arg2);
    }

    public entry fun crank_start(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::start_cranking(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

