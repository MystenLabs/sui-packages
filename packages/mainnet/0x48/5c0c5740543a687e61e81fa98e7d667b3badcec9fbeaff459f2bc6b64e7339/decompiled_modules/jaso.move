module 0x485c0c5740543a687e61e81fa98e7d667b3badcec9fbeaff459f2bc6b64e7339::jaso {
    struct JASO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JASO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JASO>(arg0, 9, b"JASO", b"KING", b"Baby king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9ef0355-549d-4738-a7da-a75bd2bcbced.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JASO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JASO>>(v1);
    }

    // decompiled from Move bytecode v6
}

