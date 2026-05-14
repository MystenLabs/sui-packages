module 0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::sui_flp_1 {
    struct SUI_FLP_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_FLP_1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUI_FLP_1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::Flp1<0x2::sui::SUI>>>(0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::new_display<0x2::sui::SUI>(&v0, 0x1::string::utf8(b"SUI FLP-1 #{number}"), 0x1::string::utf8(b"Proof of participation in Current FLP-1, granting access to exclusive rewards for founding SUI liquidity partners on Sui."), 0x1::string::utf8(b"https://metadata.current.finance/flp-1-sui.png"), arg1), 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::new_policy<0x2::sui::SUI>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::Flp1<0x2::sui::SUI>>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::Flp1<0x2::sui::SUI>>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_sui(arg0: &0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::MintCap, arg1: &mut 0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::pool::Pool<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::Flp1<0x2::sui::SUI> {
        0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::flp::mint<0x2::sui::SUI>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

