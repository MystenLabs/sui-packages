module 0x319cbe63e929b191f1d8a96e3077472ed005da87a98e5b62f70971c6120a34f::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 9, b"BABY", b"KING", b"Baby king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e954bc9b-103f-47f2-bd6d-746fad085095.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

