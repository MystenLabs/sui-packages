module 0x75421bc3253ca69f2e0b99c47fcd8a6660d61cfb39d3ddee16a74651792ca30d::jok {
    struct JOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOK>(arg0, 9, b"JOK", b"JOKER", b"MEME JOKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34e8c372-d776-4fe8-b818-db525ab8c9cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

