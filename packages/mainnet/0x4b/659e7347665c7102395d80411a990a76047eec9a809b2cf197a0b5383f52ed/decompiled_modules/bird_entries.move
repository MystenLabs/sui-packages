module 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird_entries {
    public entry fun claimPreyReward(arg0: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdArchieve, arg1: &0x2::clock::Clock, arg2: &0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::claimPreyReward(arg0, arg1, arg2, arg3);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x684fe5f9ae0d4c461b44e2190a73ec5c1477f17e56e98ddab06a384fda2aafdd::nft::BirdNFT, arg3: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdStore, arg4: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdArchieve, arg5: &0x2::clock::Clock, arg6: &0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun infoBirdGhost(arg0: &0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdArchieve) : (address, u64, u128) {
        0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::infoBirdGhost(arg0)
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdStore, arg3: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::BirdStore, arg3: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::version::Version) {
        0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_cap<T0: store + key>(arg0: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_cap<T0: store + key>(arg0: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x4b659e7347665c7102395d80411a990a76047eec9a809b2cf197a0b5383f52ed::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

