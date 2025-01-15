module 0x963d708b564e3dacd84a4e3900af040ebdcd4113ae2f404079973041e78b96c9::dnb {
    struct DNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNB>(arg0, 6, b"Dnb", b"Donotbuy", x"446f206e6f7420627579200a497320612074657374206f6e20537569206d656d65206372656174696f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1966_7afb071919.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

