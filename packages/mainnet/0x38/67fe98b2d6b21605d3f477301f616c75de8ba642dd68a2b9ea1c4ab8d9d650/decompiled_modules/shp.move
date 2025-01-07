module 0x3867fe98b2d6b21605d3f477301f616c75de8ba642dd68a2b9ea1c4ab8d9d650::shp {
    struct SHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHP>(arg0, 6, b"SHP", b"Seal Hippo On Sui", b"A new meme coin has emerged featuring a hippo sitting in a bathtub, wrapped in a towel, looking toward a green future. Called Seal Hippo, it lures investors with the promise of a world of renewable energy and humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_16_14_20_15_e43e2d6b25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHP>>(v1);
    }

    // decompiled from Move bytecode v6
}

