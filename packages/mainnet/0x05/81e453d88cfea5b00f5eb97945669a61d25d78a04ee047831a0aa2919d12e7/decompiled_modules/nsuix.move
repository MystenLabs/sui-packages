module 0x581e453d88cfea5b00f5eb97945669a61d25d78a04ee047831a0aa2919d12e7::nsuix {
    struct NSUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSUIX>(arg0, 6, b"NSUIX", b"No Sex In the Champagne Room", b"\"No Sex (In the Champagne Room)\" is a comedic spoken word track released by Chris Rock on his 1999 album, Bigger & Blacker, with a background chorus sung by Gerald Levert. Intended as a parody of Baz Luhrmann's \"Everybody's Free\", Rock gives one-line tidbits of advice purportedly aimed at \"the GED class of 1999\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_0464_6ca5c5abbb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSUIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

