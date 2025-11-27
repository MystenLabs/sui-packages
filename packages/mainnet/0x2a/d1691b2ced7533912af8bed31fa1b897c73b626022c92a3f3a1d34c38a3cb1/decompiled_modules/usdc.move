module 0x2ad1691b2ced7533912af8bed31fa1b897c73b626022c92a3f3a1d34c38a3cb1::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xce0ca45b2ed62ad74b50ce0d6bbf94dfb20b4eeca4d72977e8d3fc800502bd08::upgrade_service::new<USDC>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDC>(v1, 6, b"USDC", b"USDC", b"USDC is a US dollar-backed stablecoin issued by Circle. USDC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v4);
        0x2::transfer::public_share_object<0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::Treasury<USDC>>(0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::treasury::new<USDC>(v2, v3, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0xce0ca45b2ed62ad74b50ce0d6bbf94dfb20b4eeca4d72977e8d3fc800502bd08::upgrade_service::UpgradeService<USDC>>(v0);
    }

    // decompiled from Move bytecode v6
}

