module 0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent {
    public fun collect_to<T0>(arg0: &mut 0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent_config::DepositAgentConfig, arg1: &0x2::clock::Clock, arg2: &0x57c9cb0c610e1b23ae18eb8c85310ee45101740f042bae62775714db57132a30::cloud_wallet_config::CloudWalletConfig, arg3: &mut 0x57c9cb0c610e1b23ae18eb8c85310ee45101740f042bae62775714db57132a30::cloud_wallet_config::CloudWalletTokenHolder, arg4: u256, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: address, arg7: 0x1::string::String, arg8: u64, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent_config::only_allow_version(arg0);
        0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent_config::only_trusted_bot(arg0, arg10);
        0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent_config::when_not_paused(arg0);
        0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent_config::when_not_expired(arg1, arg8);
        0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent_config::when_to_address_match(arg3, arg6);
        0x7ba6670f14d590be2a71cc642345161102a85fbec8a78a903635fbf2caa71bbd::deposit_agent_config::token_holder_receive<T0>(arg0, arg2, arg3, arg4, arg5, arg7, arg6, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v6
}

