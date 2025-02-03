module 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault_state {
    public entry fun mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::VaultCap, arg1: &mut 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg2: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg2);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::mark_state_as_ready_for_withdrawal_processing<T0, T1, T2>(arg1, arg3);
    }

    public entry fun pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::VaultCap, arg1: &mut 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg3);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::pause_strategy_and_mark_ready_for_deposit_processing<T0, T1, T2>(arg1, arg2, arg4);
    }

    public entry fun start_strategy<T0, T1, T2>(arg0: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::VaultCap, arg1: &mut 0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::Vault<T0, T1, T2>, arg2: &0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::version::assert_current_version(arg2);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x371ef844d955f906c653eb22211441b6c8803404e012ee76a1a5e0ac1c1ee263::vault::start_strategy<T0, T1, T2>(arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

