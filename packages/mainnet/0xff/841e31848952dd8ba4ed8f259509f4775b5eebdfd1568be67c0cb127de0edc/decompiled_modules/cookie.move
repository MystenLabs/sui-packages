module 0xff841e31848952dd8ba4ed8f259509f4775b5eebdfd1568be67c0cb127de0edc::cookie {
    struct COOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKIE>(arg0, 6, b"COOKIE", b"Xmas Cookie", b"The only cookie you HODL instead of eat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatar_X_72d7683f79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

