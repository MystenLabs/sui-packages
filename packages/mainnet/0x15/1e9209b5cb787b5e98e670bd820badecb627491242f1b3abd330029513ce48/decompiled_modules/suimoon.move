module 0x151e9209b5cb787b5e98e670bd820badecb627491242f1b3abd330029513ce48::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 6, b"SUIMOON", b"SUIMON", b"Meet Suimon , the token that brings the salmon vibe to the Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_19_45_51_ca1686483c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

