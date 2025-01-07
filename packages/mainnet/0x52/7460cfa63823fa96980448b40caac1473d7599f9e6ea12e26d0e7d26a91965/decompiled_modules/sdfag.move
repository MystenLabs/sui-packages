module 0x527460cfa63823fa96980448b40caac1473d7599f9e6ea12e26d0e7d26a91965::sdfag {
    struct SDFAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFAG>(arg0, 9, b"SDFAG", b"NG", b" BX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ce01d66-7e4a-4ebe-a80b-80a23ea62091.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDFAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

