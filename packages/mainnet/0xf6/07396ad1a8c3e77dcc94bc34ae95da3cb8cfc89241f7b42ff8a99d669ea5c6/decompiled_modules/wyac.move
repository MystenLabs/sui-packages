module 0xf607396ad1a8c3e77dcc94bc34ae95da3cb8cfc89241f7b42ff8a99d669ea5c6::wyac {
    struct WYAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYAC>(arg0, 6, b"WYAC", b"Woman Yelling at Cat", b"Aaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0683_d0b6a9e2b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WYAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

