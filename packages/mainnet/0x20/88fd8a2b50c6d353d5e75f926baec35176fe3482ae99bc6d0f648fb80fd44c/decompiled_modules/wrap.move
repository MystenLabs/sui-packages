module 0x2088fd8a2b50c6d353d5e75f926baec35176fe3482ae99bc6d0f648fb80fd44c::wrap {
    struct WRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRAP>(arg0, 6, b"WRAP", b"Penguin Wrapped To Go", b"Ready for Pickup ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1d76779ae436acfd4bd51d9fff219ace_a7e56f85f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

