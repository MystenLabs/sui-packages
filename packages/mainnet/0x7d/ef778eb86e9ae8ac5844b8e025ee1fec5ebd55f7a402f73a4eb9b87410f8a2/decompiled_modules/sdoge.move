module 0x7def778eb86e9ae8ac5844b8e025ee1fec5ebd55f7a402f73a4eb9b87410f8a2::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"SDOGE", b"SUIDOGE", b"Community-launched meme coinsCommunity-launched meme coins, hard at work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012879_6479f80ff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

