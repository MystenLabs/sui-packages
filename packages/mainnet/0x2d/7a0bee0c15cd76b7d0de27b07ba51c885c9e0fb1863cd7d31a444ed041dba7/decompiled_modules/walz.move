module 0x2d7a0bee0c15cd76b7d0de27b07ba51c885c9e0fb1863cd7d31a444ed041dba7::walz {
    struct WALZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALZ>(arg0, 6, b"WALZ", b"tem walz", b"-", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/temwalz_d2d26201f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

