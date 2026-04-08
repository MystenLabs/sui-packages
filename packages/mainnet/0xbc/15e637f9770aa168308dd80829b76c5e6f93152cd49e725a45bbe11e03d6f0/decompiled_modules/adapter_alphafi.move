module 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::adapter_alphafi {
    public fun deposit<T0>(arg0: &mut 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::vault::Vault<T0>, arg1: &0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::strategy::StrategyRegistry, arg2: &0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::crank::CrankConfig, arg3: &mut 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::alpha_lending::LendingProtocol, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::alpha_lending::add_collateral<T0>(arg3, 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::protocol_caps::borrow_alphafi_position_cap_mut<T0>(arg0, 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::crank::get_access_cap(arg2, arg1)), arg4, arg5, arg6);
    }

    public fun withdraw<T0>(arg0: &mut 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::vault::Vault<T0>, arg1: &0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::strategy::StrategyRegistry, arg2: &0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::crank::CrankConfig, arg3: &mut 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::alpha_lending::LendingProtocol, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::alpha_lending::fulfill_promise<T0>(arg3, 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::alpha_lending::remove_collateral<T0>(arg3, 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::protocol_caps::borrow_alphafi_position_cap_mut<T0>(arg0, 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::crank::get_access_cap(arg2, arg1)), arg4, arg5, arg6), arg6)
    }

    // decompiled from Move bytecode v6
}

