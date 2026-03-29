module 0x1a8da45a4366b3f6d87f4406df0a536cf5ae074ddb5983475477d4cd747ae267::navi_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        account_cap: 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::account::AccountCap,
    }

    public fun create_bridge_state(arg0: 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::account::AccountCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id          : 0x2::object::new(arg1),
            account_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_navi<T0>(arg0: &mut BridgeState, arg1: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::storage::Storage, arg2: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::pool::Pool, arg3: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg4: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg5: u8, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>) {
        0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v3_fns::deposit_with_account_cap<T0>(arg6, arg1, arg2, arg5, arg7, arg3, arg4, &arg0.account_cap);
    }

    public fun harvest_rewards_navi<T0>(arg0: &mut BridgeState, arg1: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::storage::Storage, arg2: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v3_fns::claim_rewards<T0>(arg3, arg2, arg1, &arg0.account_cap, arg4)
    }

    public fun withdraw_from_navi<T0>(arg0: &mut BridgeState, arg1: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::storage::Storage, arg2: &0xd859274ff494dcb0125ed72d1297184cce5c15da54e83ed294735d438d43fee8::oracle::PriceOracle, arg3: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::pool::Pool, arg4: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg5: &mut 0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v2::Incentive, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xcf9cfb3b52226464a70d175a451246f1d15c92fe36995fc18ac166554a626b6f::incentive_v3_fns::withdraw_with_account_cap_v2<T0>(arg9, arg2, arg1, arg3, arg7, arg8, arg4, arg5, &arg0.account_cap, arg6, arg10), arg10)
    }

    // decompiled from Move bytecode v6
}

