module 0x85419ecc32d50bd4e7f1dd3b271132d260d313a40219c1b782fb20900f066848::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"Wolf", b"Landwolf on Sui", b"Landwolf on Sui, for fast transaction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8999_aa8e9e975a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

