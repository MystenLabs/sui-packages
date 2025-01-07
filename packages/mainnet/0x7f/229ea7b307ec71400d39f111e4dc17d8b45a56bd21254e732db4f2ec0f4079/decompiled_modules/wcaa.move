module 0x7f229ea7b307ec71400d39f111e4dc17d8b45a56bd21254e732db4f2ec0f4079::wcaa {
    struct WCAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAA>(arg0, 9, b"WCAA", b"Wood", b"Wood meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85d3e1a4-2c6d-41d8-822a-95c0855cf879.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

