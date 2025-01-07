module 0xb31c9e95620969c5517fe7bc528fd2af4ac39dc49da0a8758c9338f92ac83a9::tillu {
    struct TILLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TILLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TILLU>(arg0, 9, b"TILLU", b"DjTillu", x"476f696e6720746f2074686520f09f8c99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4afe62b-c3db-447a-b4ed-ab8873e51602.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TILLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TILLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

