module 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v3_fns {
    public fun claim_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg2: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::storage::Storage, arg3: &0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::account::AccountCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::storage::Storage, arg2: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::pool::Pool, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg6: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg7: &0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::account::AccountCap) {
        abort 0
    }

    public fun withdraw_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xf83be64a14593874110c88fce102b91015c16fb0fd5716e0eafa43874bcd9584::oracle::PriceOracle, arg2: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::storage::Storage, arg3: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::pool::Pool, arg4: u8, arg5: u64, arg6: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg7: &mut 0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::incentive_v2::Incentive, arg8: &0x693148b19f037763852f3b58d8cd22f2265d7db3069b96baf1f3161cf9e3bdf::account::AccountCap, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

