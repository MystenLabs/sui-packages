module 0xce58aeb699e18d6b5686097398cd40ebe187e7f9491903a750b8cb7652ffcbde::dummy_project {
    struct DUMMY_PROJECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY_PROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<DUMMY_PROJECT>>(0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::new_project_admin_cap<DUMMY_PROJECT>(&arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::AirdropTokenWithdrawCap<DUMMY_PROJECT>>(0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::new_airdrop_token_withdraw_cap<DUMMY_PROJECT>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

