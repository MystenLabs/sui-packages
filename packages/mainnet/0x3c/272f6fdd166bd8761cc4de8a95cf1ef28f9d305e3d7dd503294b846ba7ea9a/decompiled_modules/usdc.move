module 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::upgrade_service::new<USDC>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDC>(v1, 6, b"USDC", b"USDC", b"USDC is a US dollar-backed stablecoin issued by Circle. USDC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v4);
        0x2::transfer::public_share_object<0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::Treasury<USDC>>(0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::treasury::new<USDC>(v2, v3, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0x3c272f6fdd166bd8761cc4de8a95cf1ef28f9d305e3d7dd503294b846ba7ea9a::upgrade_service::UpgradeService<USDC>>(v0);
    }

    // decompiled from Move bytecode v6
}

