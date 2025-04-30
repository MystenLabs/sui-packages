module 0xfc6331c0c936fb758e18caddbe41414f4f6719dd2178656125435ee0232bc13f::groke {
    struct GROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKE>(arg0, 6, b"GROKE", b"The Groke", x"47726f6b652069732061206c6f6e676c792070656e6775696e2e202020202447524f4b450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/groke_logo_77f1df6f51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

