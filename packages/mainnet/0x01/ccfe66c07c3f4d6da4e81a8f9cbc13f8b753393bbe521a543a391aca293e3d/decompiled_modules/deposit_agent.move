module 0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent {
    public fun collect_to<T0>(arg0: &mut 0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent_config::DepositAgentConfig, arg1: &0x2::clock::Clock, arg2: &0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletConfig, arg3: &mut 0xbb24680526bd0d6d36e83f77904e6b233a111fa13dbebadfe5e9e44fbd66fb51::cloud_wallet_config::CloudWalletTokenHolder, arg4: u256, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: address, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent_config::only_allow_version(arg0);
        0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent_config::only_trusted_bot(arg0, arg9);
        0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent_config::when_not_paused(arg0);
        0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent_config::when_not_expired(arg1, arg7);
        0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent_config::when_to_address_match(arg3, arg6);
        0x1ccfe66c07c3f4d6da4e81a8f9cbc13f8b753393bbe521a543a391aca293e3d::deposit_agent_config::token_holder_receive<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

