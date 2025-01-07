module 0xfe4aec0199f96c9e305a72180779907d6dd1a6b646e733d786691e43902bc54d::vulgarian {
    struct VULGARIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VULGARIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VULGARIAN>(arg0, 6, b"VULGARIAN", b"Stupid Rich Man", b" spend all their money in the stupidest ways possible", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdsad_ea614bad58.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VULGARIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VULGARIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

