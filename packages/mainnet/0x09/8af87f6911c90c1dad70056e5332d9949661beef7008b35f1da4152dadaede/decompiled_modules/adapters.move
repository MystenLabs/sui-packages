module 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::adapters {
    public fun alphalend_liquidate<T0, T1>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg4, arg6), arg5, arg6);
        (0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg0, v0, arg5, arg6)), 0x2::coin::into_balance<T0>(v1))
    }

    public fun alphalend_liquidate_sui<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg0, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(arg5, arg7), arg6, arg7);
        (0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg0, v0, arg1, arg6, arg7)), 0x2::coin::into_balance<T0>(v1))
    }

    public fun alphalend_precheck(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: u64) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_debt(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg0, arg1, arg2, arg3), arg4);
    }

    public fun scallop_liquidate<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::balance::Balance<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T0>(arg3, arg7), arg4, arg5, arg6, arg7);
        (0x2::coin::into_balance<T1>(v1), 0x2::coin::into_balance<T0>(v0))
    }

    public fun scallop_precheck_unlocked(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_liquidatable(!0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg0));
    }

    // decompiled from Move bytecode v7
}

