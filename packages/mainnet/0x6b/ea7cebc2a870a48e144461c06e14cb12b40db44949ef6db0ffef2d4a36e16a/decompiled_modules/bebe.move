module 0x6bea7cebc2a870a48e144461c06e14cb12b40db44949ef6db0ffef2d4a36e16a::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBE>(arg0, 6, b"BEBE", b"BEBE THE BLUE FROG", b"BeBe Is the Elder Blue Frog from\"Mindviscosity\"He Is seen amongst Other characters Ohare, Groggo, Rainbow, FeFe , Scaley and Wolf Skull.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_20_08_12_802ddc5eba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

