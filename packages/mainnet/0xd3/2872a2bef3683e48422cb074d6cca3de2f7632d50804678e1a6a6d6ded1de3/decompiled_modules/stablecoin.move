module 0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x795f9c96e043c7ad2f5789d19e21e6768962b5c846ba4ade8910b00e8ea9c347::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x795f9c96e043c7ad2f5789d19e21e6768962b5c846ba4ade8910b00e8ea9c347::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

