module 0x409465673d5867d22e4573e735369b933f8e9bbe11a946784390fa2700fba839::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"Krueger", b"Buying Meme Coins is a sign of lower intelligence. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fredsmeme_895167ac37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

