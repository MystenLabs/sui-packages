module 0x67e5a726e21485c00d1b305419c3d4ca1da168df27341debafa1d8d80ad37427::anitamw {
    struct ANITAMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANITAMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANITAMW>(arg0, 6, b"AnitaMW", b"Anita Max Wynn", b"The original ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731178004390.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANITAMW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANITAMW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

