module 0xdd6a53fdb0b3d9125b94062e58354ead1899614d6bb21a34dabc20e4b42033::brozo {
    struct BROZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROZO>(arg0, 6, b"BROZO", b"Bozo Katz", b"When this hits, don't say we didn't warn you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6lmu7upusvehdz7zlsqcxbeetqlgd4ezpcnnisuxrqk4uzdtwva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

