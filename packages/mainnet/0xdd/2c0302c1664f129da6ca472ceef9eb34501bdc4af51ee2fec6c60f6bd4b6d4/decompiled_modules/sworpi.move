module 0xdd2c0302c1664f129da6ca472ceef9eb34501bdc4af51ee2fec6c60f6bd4b6d4::sworpi {
    struct SWORPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWORPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWORPI>(arg0, 6, b"SWORPI", b"SWORPI ON SUI", b"Meet sworpi the sworp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_4_4b13929916.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWORPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWORPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

