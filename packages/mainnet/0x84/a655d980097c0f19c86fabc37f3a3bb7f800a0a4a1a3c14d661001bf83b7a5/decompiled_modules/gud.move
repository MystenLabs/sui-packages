module 0x84a655d980097c0f19c86fabc37f3a3bb7f800a0a4a1a3c14d661001bf83b7a5::gud {
    struct GUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUD>(arg0, 6, b"Gud", b"Gudetama", b"Gudetama on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gudetama_b213fa4475.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

