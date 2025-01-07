module 0x9abf006172c024f44d6082fdb4511b0dc4e5636784c1a998b7325b66bdacc94f::ripdip {
    struct RIPDIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPDIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPDIP>(arg0, 6, b"RipDip", b"ripdip", b"Welcome to the RipDip fam!  Get ready to unleash your inner meme lord and ride the waves of laughter and crypto gains!  Grab your popcorn and join the fun-filled journey of RipDip. Let's dive in together and make some hilarious and profitable memories! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rip_Dip_PNG_b97d77c1e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPDIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPDIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

