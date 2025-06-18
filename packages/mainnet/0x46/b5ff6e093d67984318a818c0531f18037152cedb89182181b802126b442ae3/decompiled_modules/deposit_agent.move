module 0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent {
    public fun collect_to<T0>(arg0: &mut 0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent_config::DepositAgentConfig, arg1: &0x2::clock::Clock, arg2: &0xb664e5f1e85cec77d0da9097e18fa602cfefa7a0e16f28d7396e806dc90e74f0::cloud_wallet_config::CloudWalletConfig, arg3: &mut 0xb664e5f1e85cec77d0da9097e18fa602cfefa7a0e16f28d7396e806dc90e74f0::cloud_wallet_config::CloudWalletTokenHolder, arg4: u256, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: address, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent_config::only_allow_version(arg0);
        0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent_config::only_trusted_bot(arg0, arg9);
        0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent_config::when_not_paused(arg0);
        0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent_config::when_not_expired(arg1, arg7);
        0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent_config::when_to_address_match(arg3, arg6);
        0x46b5ff6e093d67984318a818c0531f18037152cedb89182181b802126b442ae3::deposit_agent_config::token_holder_receive<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

