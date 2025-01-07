module 0x6070099fba7776a468bd0789c1b62bb217f27545489bdfad1e70ef4b9e5f9691::chillbull {
    struct CHILLBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBULL>(arg0, 6, b"CHILLBULL", b"CHILL BULL", b"The Chill Bull on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_23_15_36_38_b692e0cd22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

