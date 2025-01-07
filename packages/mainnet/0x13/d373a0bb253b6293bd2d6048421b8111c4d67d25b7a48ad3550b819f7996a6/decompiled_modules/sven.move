module 0x13d373a0bb253b6293bd2d6048421b8111c4d67d25b7a48ad3550b819f7996a6::sven {
    struct SVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVEN>(arg0, 6, b"SVEN", b"sven on sui", b"sven the slow swan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5883703143395_8a6e81968b9cd3f11074db5db2e75c95_8a6cf0cb9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

