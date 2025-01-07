module 0x99009808e54d42eac0a2e4f0770fdc3682991bd0f89acb2e9c9a5ce97691968::aaashiba {
    struct AAASHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASHIBA>(arg0, 6, b"AAASHIBA", b"aaashibaaa", b"aaaaaaaaaashibaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_5c4a2a2342.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAASHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

