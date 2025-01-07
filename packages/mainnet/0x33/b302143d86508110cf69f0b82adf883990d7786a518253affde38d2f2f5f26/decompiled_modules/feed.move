module 0x33b302143d86508110cf69f0b82adf883990d7786a518253affde38d2f2f5f26::feed {
    struct FEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEED>(arg0, 6, b"FEED", b"Feed Dog", b"oooh food $FEED feeeeeeeeeeeeeeeeeed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002331_c177652562.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

