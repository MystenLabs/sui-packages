module 0x3d95d1eea98fb2e6215042e2a81d071a875b7d5a12a23958ce365ae9a6a051b::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x795f9c96e043c7ad2f5789d19e21e6768962b5c846ba4ade8910b00e8ea9c347::upgrade_service::new<USDC>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDC>(v1, 6, b"USDC", b"USDC", b"USDC is a US dollar-backed stablecoin issued by Circle. USDC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v4);
        0x2::transfer::public_share_object<0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::Treasury<USDC>>(0xd32872a2bef3683e48422cb074d6cca3de2f7632d50804678e1a6a6d6ded1de3::treasury::new<USDC>(v2, v3, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0x795f9c96e043c7ad2f5789d19e21e6768962b5c846ba4ade8910b00e8ea9c347::upgrade_service::UpgradeService<USDC>>(v0);
    }

    // decompiled from Move bytecode v6
}

