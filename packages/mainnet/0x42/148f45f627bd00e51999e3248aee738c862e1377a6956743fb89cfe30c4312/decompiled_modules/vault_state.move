module 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &mut 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::Vault<T0, T1, T2>, arg1: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::assert_current_version(arg1);
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg2);
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0, arg2);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &mut 0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::Vault<T0, T1, T2>, arg1: &0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::version::assert_current_version(arg1);
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::assert_address_whitelisted<T0, T1, T2>(arg0, arg3);
        0x42148f45f627bd00e51999e3248aee738c862e1377a6956743fb89cfe30c4312::vault::start_strategy<T0, T1, T2>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

