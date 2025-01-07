module 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird_entries {
    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdStore, arg3: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x684fe5f9ae0d4c461b44e2190a73ec5c1477f17e56e98ddab06a384fda2aafdd::nft::BirdNFT, arg3: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdStore, arg4: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdArchieve, arg5: &0x2::clock::Clock, arg6: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun infoBirdGhost(arg0: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdArchieve) : (address, u64, u128) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::infoBirdGhost(arg0)
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdStore, arg3: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::BirdStore, arg3: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::version::Version) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_cap<T0: store + key>(arg0: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_cap<T0: store + key>(arg0: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x23dd40a01481ef1d041f6e1ba03bc7dec40dcb3b554652be7d7328a88cc2aee2::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

