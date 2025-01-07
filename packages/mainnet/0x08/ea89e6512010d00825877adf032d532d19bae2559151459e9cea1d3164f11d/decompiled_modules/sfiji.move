module 0x8ea89e6512010d00825877adf032d532d19bae2559151459e9cea1d3164f11d::sfiji {
    struct SFIJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFIJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFIJI>(arg0, 6, b"SFIJI", b"Sui Fiji Water", b"drink water everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aqua_fiji_cab2436c65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFIJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFIJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

