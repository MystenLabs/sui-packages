module 0x9bb9dc02deb67065eccc9190c07f966c42eb15dd2708154b3936f6e27d1f1bc1::swifties {
    struct SWIFTIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFTIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIFTIES>(arg0, 6, b"SWIFTIES", b"TAYLOR SWIFT", b"Swifties dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_21_16_41_10_53b0007feb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFTIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIFTIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

