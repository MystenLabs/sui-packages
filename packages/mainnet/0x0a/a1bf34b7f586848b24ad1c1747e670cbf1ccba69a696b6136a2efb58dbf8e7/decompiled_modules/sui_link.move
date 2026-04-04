module 0xaa1bf34b7f586848b24ad1c1747e670cbf1ccba69a696b6136a2efb58dbf8e7::sui_link {
    struct SUI_LINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LINK>(arg0, 6, b"SUI LINK", b"Sui Link", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_LINK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_LINK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_LINK>>(v2);
    }

    // decompiled from Move bytecode v6
}

