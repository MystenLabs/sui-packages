module 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::incentive_v3_fns {
    public fun claim_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::incentive_v2::Incentive, arg2: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::storage::Storage, arg3: &0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::account::AccountCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::storage::Storage, arg2: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::pool::Pool, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::incentive_v2::Incentive, arg6: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::incentive_v2::Incentive, arg7: &0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::account::AccountCap) {
        abort 0
    }

    public fun withdraw_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0x4c2f371e08e1454d31bd8b9c8590d8f425b8beacd7c1a8cb578eec72c62654b9::oracle::PriceOracle, arg2: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::storage::Storage, arg3: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::pool::Pool, arg4: u8, arg5: u64, arg6: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::incentive_v2::Incentive, arg7: &mut 0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::incentive_v2::Incentive, arg8: &0x9c89e84ff649c8ce1bc837cada29f673618cd5a27256a6ea9c9d8521e45e477c::account::AccountCap, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

