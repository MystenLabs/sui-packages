module 0xa77eddb4c3a8c854882876ef7dfef81061ceb1aca1d59a9da0705d3eac06d80b::tyler {
    struct TYLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYLER>(arg0, 6, b"TYLER", b"TYLER'S HOLIDAY", b"wishing you all a prosperous HOLIDAY,with that,let us all meet at DEXSCREENER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tyler1_aad1f2a313.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

