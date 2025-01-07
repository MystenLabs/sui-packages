module 0x821f0adbdab722d7e0b50c7877e7b5fa9c5cfce856ae12c728b9a6a0a6b5509d::bimpson {
    struct BIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIMPSON>(arg0, 6, b"Bimpson", b"SUI Simpson", b"It's time to turn your 'D'ohs' into Dough with Bimpson the Base Simpson.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_04_19_56_db2c4d34f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

