module 0x9e994e55fd344e9915404eb281ab8e7ce69706227e6abfb0c933ae99a13f3da3::pff {
    struct PFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFF>(arg0, 6, b"PFF", b"Play For Fun", b"Play For Fun, enjoying play. There are no leaders; everything is organized and coordinated by the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_4d1f79fe86.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

