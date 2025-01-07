module 0xb874fa6df1421349f9f94933bb34abe3be15f6b62be7fc1fbf5464a60e9a5405::quackyl {
    struct QUACKYL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACKYL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACKYL>(arg0, 6, b"QUACKYL", b"TRAVELLER DUCK", b"From the ashes of disappointment emerges a phoenix of hope - QUACKY, the hero of the fallen, the beacon of light piercing through the darkness of crypto turmoil. With a noble mission to spread love and happiness, QUACKY sets out to unite people from around the globe, forging bonds stronger than any blockchain. Join the movement, and embrace the spirit of QUACKY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3434_1efdc38ba3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACKYL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACKYL>>(v1);
    }

    // decompiled from Move bytecode v6
}

