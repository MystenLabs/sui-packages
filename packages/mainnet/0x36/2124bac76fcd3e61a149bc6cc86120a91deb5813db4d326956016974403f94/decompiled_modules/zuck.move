module 0x362124bac76fcd3e61a149bc6cc86120a91deb5813db4d326956016974403f94::zuck {
    struct ZUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCK>(arg0, 6, b"ZUCK", b"MARK COCKERBERG", b"Yo, I'm Mark Cockerberg, CEO of Fapbook and founder of https://markcockerberg.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_15_12_31_58ac9b7e73.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

