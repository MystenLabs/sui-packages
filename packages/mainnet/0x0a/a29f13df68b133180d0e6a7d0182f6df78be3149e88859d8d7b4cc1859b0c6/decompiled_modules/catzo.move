module 0xaa29f13df68b133180d0e6a7d0182f6df78be3149e88859d8d7b4cc1859b0c6::catzo {
    struct CATZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZO>(arg0, 6, b"CATZO", b"Catzo", b"Catzo It's a new strong Memecoin with the power of the Cat, is coming!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036398_aa057f2e4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

