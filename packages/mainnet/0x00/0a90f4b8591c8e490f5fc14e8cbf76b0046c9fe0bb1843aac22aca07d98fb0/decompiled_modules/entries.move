module 0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::entries {
    public entry fun burn(arg0: 0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::AGENT, arg1: &0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::VaultConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::burn(arg0, arg1, arg2);
    }

    public entry fun mint(arg0: &mut 0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::VaultConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::UserArchive, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::AGENT>(0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun set_validator(arg0: &0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::AdminCap, arg1: &mut 0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::VaultConfig, arg2: vector<u8>) {
        0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::set_validator(arg0, arg1, arg2);
    }

    public entry fun withdraw_fee(arg0: &0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::AdminCap, arg1: &mut 0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::VaultConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa90f4b8591c8e490f5fc14e8cbf76b0046c9fe0bb1843aac22aca07d98fb0::agent_nft::withdraw_fee(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

