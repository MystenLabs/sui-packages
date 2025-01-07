module 0xc30f66bd9af9c199d8b06c63d8eaa479e06d9fa2ad80705bbfdcb8bcdc00f470::turboysui {
    struct TURBOYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOYSUI>(arg0, 6, b"TURBOYSUI", b"TURBOY SUI", b"TURBOYSUI: The Ultimate Meme Coin Revolution on the SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731172404371.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOYSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

