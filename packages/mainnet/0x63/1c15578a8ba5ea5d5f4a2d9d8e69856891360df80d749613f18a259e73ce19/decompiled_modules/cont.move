module 0x631c15578a8ba5ea5d5f4a2d9d8e69856891360df80d749613f18a259e73ce19::cont {
    struct CONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONT>(arg0, 9, b"CONT", b"continental", b"-", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e131203c6dbab37922f9d00ab3231711blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

