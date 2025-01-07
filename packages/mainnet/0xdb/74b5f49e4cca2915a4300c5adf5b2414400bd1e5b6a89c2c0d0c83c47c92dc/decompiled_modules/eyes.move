module 0xdb74b5f49e4cca2915a4300c5adf5b2414400bd1e5b6a89c2c0d0c83c47c92dc::eyes {
    struct EYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYES>(arg0, 6, b"EYES", b"Sui Eyes Dragon", b"Blue Eyes White Dragon Come To SUI Network transform into $EYES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_13_07_44_40_d29c84f65f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYES>>(v1);
    }

    // decompiled from Move bytecode v6
}

