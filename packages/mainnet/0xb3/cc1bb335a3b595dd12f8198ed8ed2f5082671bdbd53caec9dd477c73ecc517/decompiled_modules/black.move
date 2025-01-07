module 0xb3cc1bb335a3b595dd12f8198ed8ed2f5082671bdbd53caec9dd477c73ecc517::black {
    struct BLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK>(arg0, 6, b"BLACK", b"Blackchain", b"Let us be unburdened by what has been.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_111055_d14bc20fea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

