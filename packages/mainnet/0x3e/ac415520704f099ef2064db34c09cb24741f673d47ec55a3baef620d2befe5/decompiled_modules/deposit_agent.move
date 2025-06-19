module 0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent {
    public fun collect_to<T0>(arg0: &mut 0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent_config::DepositAgentConfig, arg1: &0x2::clock::Clock, arg2: &0x9219597c1cba4edb5536c2d2c3100473224e04ae0b34e1300488e69b387be4ed::cloud_wallet_config::CloudWalletConfig, arg3: &mut 0x9219597c1cba4edb5536c2d2c3100473224e04ae0b34e1300488e69b387be4ed::cloud_wallet_config::CloudWalletTokenHolder, arg4: u256, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: address, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent_config::only_allow_version(arg0);
        0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent_config::only_trusted_bot(arg0, arg9);
        0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent_config::when_not_paused(arg0);
        0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent_config::when_not_expired(arg1, arg7);
        0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent_config::when_to_address_match(arg3, arg6);
        0x3eac415520704f099ef2064db34c09cb24741f673d47ec55a3baef620d2befe5::deposit_agent_config::token_holder_receive<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

