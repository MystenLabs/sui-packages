module 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::entries {
    public entry fun add_whitelist<T0, T1>(arg0: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg1: vector<address>, arg2: vector<u64>, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::add_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy<T0, T1>(arg0: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg4: &0x2::tx_context::TxContext) : (u64, u64) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::buy<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun claim<T0, T1>(arg0: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::claim<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun distribute_fund_to_owner<T0, T1>(arg0: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::distribute_fund_to_owner<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun new_project<T0, T1>(arg0: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::AdminCap, arg1: address, arg2: address, arg3: u8, arg4: 0x2::coin::TreasuryCap<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg11: &mut 0x2::tx_context::TxContext) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::new_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun refund<T0, T1>(arg0: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::refund<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg1: vector<address>, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::remove_whitelist<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun setup_project_launch_info<T0, T1>(arg0: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::AdminCap, arg1: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::setup_project_launch_state<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun trigger_project_status<T0, T1>(arg0: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::AdminCap, arg1: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg2: bool, arg3: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::trigger_project_status<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_project<T0, T1>(arg0: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::AdminCap, arg1: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u8, arg7: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::update_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun withdraw_liquidity_fund<T0, T1>(arg0: &mut 0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x92f1d0d1cb4a3165ed6e4e318746a3deebcfdb0ab5b7bb13e2b7375fe0d829d2::project::withdraw_liquidity_fund<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

