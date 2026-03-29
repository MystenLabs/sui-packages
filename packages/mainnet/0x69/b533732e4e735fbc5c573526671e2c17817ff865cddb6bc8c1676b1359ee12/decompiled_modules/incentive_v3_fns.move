module 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::incentive_v3_fns {
    public fun claim_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::incentive_v2::Incentive, arg2: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::storage::Storage, arg3: &0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::account::AccountCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::storage::Storage, arg2: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::pool::Pool, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::incentive_v2::Incentive, arg6: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::incentive_v2::Incentive, arg7: &0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::account::AccountCap) {
        abort 0
    }

    public fun withdraw_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0x65e61946ce4033db249400f0b0e6f6853b3a2ac0a81fbe4b2b70b0608dc0ef13::oracle::PriceOracle, arg2: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::storage::Storage, arg3: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::pool::Pool, arg4: u8, arg5: u64, arg6: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::incentive_v2::Incentive, arg7: &mut 0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::incentive_v2::Incentive, arg8: &0x69b533732e4e735fbc5c573526671e2c17817ff865cddb6bc8c1676b1359ee12::account::AccountCap, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

