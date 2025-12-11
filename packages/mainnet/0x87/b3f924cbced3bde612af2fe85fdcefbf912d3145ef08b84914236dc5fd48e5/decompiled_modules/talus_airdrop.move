module 0x87b3f924cbced3bde612af2fe85fdcefbf912d3145ef08b84914236dc5fd48e5::talus_airdrop {
    struct TALUS_AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALUS_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<TALUS_AIRDROP>>(0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::new_project_admin_cap<TALUS_AIRDROP>(&arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::AirdropTokenWithdrawCap<TALUS_AIRDROP>>(0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::new_airdrop_token_withdraw_cap<TALUS_AIRDROP>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

