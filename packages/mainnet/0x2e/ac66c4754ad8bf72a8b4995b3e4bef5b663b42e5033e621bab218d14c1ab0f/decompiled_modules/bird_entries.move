module 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird_entries {
    public entry fun claimPreyReward(arg0: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdArchieve, arg1: &0x2::clock::Clock, arg2: &0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::claimPreyReward(arg0, arg1, arg2, arg3);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x684fe5f9ae0d4c461b44e2190a73ec5c1477f17e56e98ddab06a384fda2aafdd::nft::BirdNFT, arg3: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdStore, arg4: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdArchieve, arg5: &0x2::clock::Clock, arg6: &0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun infoBirdGhost(arg0: &0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdArchieve) : (address, u64, u128) {
        0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::infoBirdGhost(arg0)
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdStore, arg3: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::BirdStore, arg3: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::version::Version) {
        0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_cap<T0: store + key>(arg0: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_cap<T0: store + key>(arg0: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2eac66c4754ad8bf72a8b4995b3e4bef5b663b42e5033e621bab218d14c1ab0f::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

