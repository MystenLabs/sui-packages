module 0x2c7f3471ae5aaa5c1872b7be8e829268e12d89f9355b457ef1db7e0911243997::elefish {
    struct ELEFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEFISH>(arg0, 6, b"ELEFISH", b"Elephant Fish", b"Swimming smart, thinking bigger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b11e8fb3e83dcf42f30f2ef32d4cddb5_5badf2d399.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

