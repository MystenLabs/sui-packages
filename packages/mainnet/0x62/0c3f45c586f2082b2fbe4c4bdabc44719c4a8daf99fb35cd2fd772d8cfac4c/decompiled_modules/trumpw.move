module 0x620c3f45c586f2082b2fbe4c4bdabc44719c4a8daf99fb35cd2fd772d8cfac4c::trumpw {
    struct TRUMPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPW>(arg0, 6, b"TRUMPW", b"TrumpWon", x"5472756d70576f6e200a0a4c61756e6368696e6720536f6f6e0a53616665205465616d0a0a68747470733a2f2f742e6d652f2b576a62415635334d394d5a6a4f445978", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5937_ca854b5023.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPW>>(v1);
    }

    // decompiled from Move bytecode v6
}

