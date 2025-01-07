module 0xa9f357b3086278721154ac33e744b42c009daedd77e4074f655671d6d95b956c::dolf {
    struct DOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLF>(arg0, 6, b"DOLF", b"Dolf of sui", b"DOLF is a young and charming dolphin that confidently surfs through the chaos of meme coins, becoming the ultimate icon of the SUI ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040600_1c6e2e7556.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

