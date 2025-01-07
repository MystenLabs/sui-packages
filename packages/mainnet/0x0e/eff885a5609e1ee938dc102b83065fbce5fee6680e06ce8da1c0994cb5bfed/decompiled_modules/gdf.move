module 0xeeff885a5609e1ee938dc102b83065fbce5fee6680e06ce8da1c0994cb5bfed::gdf {
    struct GDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDF>(arg0, 6, b"Gdf", b"Gaddafi", b"When  my conspiracy is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gaddafi_327281da66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

