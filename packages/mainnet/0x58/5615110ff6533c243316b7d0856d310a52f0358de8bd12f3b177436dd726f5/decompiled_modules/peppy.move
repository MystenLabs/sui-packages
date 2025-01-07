module 0x585615110ff6533c243316b7d0856d310a52f0358de8bd12f3b177436dd726f5::peppy {
    struct PEPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPY>(arg0, 6, b"PEPPY", b"PEPPY PANTHER", b"Slinking through the meme jungle with energy and charm. Peppy Panther is purring for profits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_22_033723011_dac091a7cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

