module 0x45fcfa5075ac9d1b8ede087177d88a613504640f366105fd203f732d54a4adac::eggt {
    struct EGGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGT>(arg0, 6, b"EGGT", b"EGG", b"EEG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_05_23_18_48_01e8ca59ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

