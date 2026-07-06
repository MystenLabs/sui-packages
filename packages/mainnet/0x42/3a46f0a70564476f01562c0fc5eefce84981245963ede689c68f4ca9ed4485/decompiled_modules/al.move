module 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::al {
    public fun l<T0, T1>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg4, arg6), arg5, arg6);
        (0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg0, v0, arg5, arg6)), 0x2::coin::into_balance<T0>(v1))
    }

    public fun l_sui<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg0, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(arg5, arg7), arg6, arg7);
        (0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg0, v0, arg1, arg6, arg7)), 0x2::coin::into_balance<T0>(v1))
    }

    // decompiled from Move bytecode v7
}

