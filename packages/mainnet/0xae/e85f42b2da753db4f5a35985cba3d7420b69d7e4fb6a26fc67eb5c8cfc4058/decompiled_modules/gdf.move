module 0xaee85f42b2da753db4f5a35985cba3d7420b69d7e4fb6a26fc67eb5c8cfc4058::gdf {
    struct GDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDF>(arg0, 6, b"GDF", b"Gaddafi", b"When  my conspiracy is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gaddafi_1507c35432.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

