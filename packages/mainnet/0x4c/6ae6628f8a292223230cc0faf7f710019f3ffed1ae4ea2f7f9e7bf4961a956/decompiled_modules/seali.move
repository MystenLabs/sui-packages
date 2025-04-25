module 0x4c6ae6628f8a292223230cc0faf7f710019f3ffed1ae4ea2f7f9e7bf4961a956::seali {
    struct SEALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALI>(arg0, 6, b"SEALI", b"SE-LN7", b"Seal x Alien. Zero Utility. infinite vibes. The new degen runner on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4665_9c93392dc2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

