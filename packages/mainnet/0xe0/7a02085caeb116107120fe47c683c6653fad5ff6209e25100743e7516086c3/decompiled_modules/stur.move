module 0xe07a02085caeb116107120fe47c683c6653fad5ff6209e25100743e7516086c3::stur {
    struct STUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUR>(arg0, 6, b"STUR", b"SUITURTLE", b"I am SuiTurtle, the worlds only turtle with taste.  They say Rome wasnt built in a day, and neither is success or extreme wealth, my friends. So come along with me on this journey  let's climb out of our shells and show the world that class never rushes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bilde_01_11_2024_klokken_17_45_6163d5d53c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

