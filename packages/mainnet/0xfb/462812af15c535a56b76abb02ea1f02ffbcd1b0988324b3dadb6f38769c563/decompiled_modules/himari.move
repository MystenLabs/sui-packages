module 0xfb462812af15c535a56b76abb02ea1f02ffbcd1b0988324b3dadb6f38769c563::himari {
    struct HIMARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIMARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIMARI>(arg0, 6, b"HIMARI", b"HIMARI ON SUI", x"5468652073696d706c65737420646f67206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_102707_581_2dbf26cbff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIMARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIMARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

