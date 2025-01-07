module 0x38c5207ee0cd27acd9e1e51bff947577c6d42902fc3d63175cc593d0a4afe7c7::rxz {
    struct RXZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RXZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RXZ>(arg0, 6, b"RXZ", b"Rxz Sui Dog", b"cute baby dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010347_2f5e0e68ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RXZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RXZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

