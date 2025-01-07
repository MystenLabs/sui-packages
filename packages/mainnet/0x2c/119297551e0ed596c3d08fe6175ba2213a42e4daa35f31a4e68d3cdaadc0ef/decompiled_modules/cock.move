module 0x2c119297551e0ed596c3d08fe6175ba2213a42e4daa35f31a4e68d3cdaadc0ef::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 6, b"Cock", b"GameCock CTO", b"GameCock created by Crypto Messiah CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_03_41_28_d677f0109b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

