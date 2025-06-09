module 0x5ecdbb09fac930d71334f93302034198af81bf43ab813e37f30e1bf153c0679a::alhas {
    struct ALHAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALHAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALHAS>(arg0, 6, b"ALHAS", b"Alya and Hassan", b"Alya and Hassan. The story of two brothers who support each other in facing everyday life problems. This story can be about friendship, competition, or even conflict between them, but in the end they remain united.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidren4irdk3o6cacnhsgvx4xt4zfwlp7erya2x66icru7hz6bpmii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALHAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALHAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

