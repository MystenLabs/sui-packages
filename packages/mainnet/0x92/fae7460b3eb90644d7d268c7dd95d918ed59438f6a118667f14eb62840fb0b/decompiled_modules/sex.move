module 0x92fae7460b3eb90644d7d268c7dd95d918ed59438f6a118667f14eb62840fb0b::sex {
    struct SEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEX>(arg0, 6, b"SEX", b"No Sex in Champagne RoOm", b"\"No Sex (In the Champagne Room)\" is a comedic spoken word track released by Chris Rock on his 1999 album, Bigger & Blacker, with a background chorus sung by Gerald Levert. Intended as a parody of Baz Luhrmann's \"Everybody's Free\", Rock gives one-line tidbits of advice purportedly aimed at \"the GED class of 1999\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_0464_0181c52b72.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

