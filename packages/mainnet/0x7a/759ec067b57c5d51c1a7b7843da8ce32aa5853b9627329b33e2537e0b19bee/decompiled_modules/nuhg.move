module 0x7a759ec067b57c5d51c1a7b7843da8ce32aa5853b9627329b33e2537e0b19bee::nuhg {
    struct NUHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUHG>(arg0, 6, b"NUHG", b"NUHGS", b"no rules, just $NUHG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NUHG_fd8046a3db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

