module 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v3_fns {
    public fun claim_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg2: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::storage::Storage, arg3: &0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::account::AccountCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::storage::Storage, arg2: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::pool::Pool, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg6: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg7: &0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::account::AccountCap) {
        abort 0
    }

    public fun withdraw_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xd859274ff494dcb0125ed72d1297184cce5c15da54e83ed294735d438d43fee8::oracle::PriceOracle, arg2: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::storage::Storage, arg3: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::pool::Pool, arg4: u8, arg5: u64, arg6: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg7: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg8: &0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::account::AccountCap, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

