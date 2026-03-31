module 0xe4b6d56581eb4934b82c24db1f395008f4c53097c597b0e1d65625c8c91f6bb0::navi_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        account_cap: 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::account::AccountCap,
    }

    public fun create_bridge_state(arg0: 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::account::AccountCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id          : 0x2::object::new(arg1),
            account_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_navi<T0>(arg0: &mut BridgeState, arg1: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::storage::Storage, arg2: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::pool::Pool, arg3: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg4: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg5: u8, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>) {
        0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v3_fns::deposit_with_account_cap<T0>(arg6, arg1, arg2, arg5, arg7, arg3, arg4, &arg0.account_cap);
    }

    public fun harvest_rewards_navi<T0>(arg0: &mut BridgeState, arg1: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::storage::Storage, arg2: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v3_fns::claim_rewards<T0>(arg3, arg2, arg1, &arg0.account_cap, arg4)
    }

    public fun withdraw_from_navi<T0>(arg0: &mut BridgeState, arg1: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::storage::Storage, arg2: &0xf83be64a14593874110c88fce102b91015c16fb0fd5716e0eafa43874bcd9584::oracle::PriceOracle, arg3: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::pool::Pool, arg4: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg5: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v3_fns::withdraw_with_account_cap_v2<T0>(arg9, arg2, arg1, arg3, arg7, arg8, arg4, arg5, &arg0.account_cap, arg6, arg10), arg10)
    }

    // decompiled from Move bytecode v6
}

