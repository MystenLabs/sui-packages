module 0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::Vault<T0, T1, T2>, arg1: &0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::version::assert_current_version(arg1);
        0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg2);
        0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg2);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::Vault<T0, T1, T2>, arg1: &0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::version::assert_current_version(arg1);
        0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg3);
        0x4abd75f09d5522b5afaedee4010edb6293ca458134d4ed6cfd1cb656febf7604::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

