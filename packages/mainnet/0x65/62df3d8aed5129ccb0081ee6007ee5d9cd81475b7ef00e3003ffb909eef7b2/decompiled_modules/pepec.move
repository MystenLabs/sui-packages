module 0x6562df3d8aed5129ccb0081ee6007ee5d9cd81475b7ef00e3003ffb909eef7b2::pepec {
    struct PEPEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEC>(arg0, 9, b"PEPEC", b"PepeCetusius", b"Pepe una meme de cetus para siempre", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://miro.medium.com/v2/resize:fit:1358/1*A4L7alvTJLlLxzDXWvM11A.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPEC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

