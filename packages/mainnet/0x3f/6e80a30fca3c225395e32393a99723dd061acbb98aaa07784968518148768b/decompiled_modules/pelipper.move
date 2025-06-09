module 0x3f6e80a30fca3c225395e32393a99723dd061acbb98aaa07784968518148768b::pelipper {
    struct PELIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELIPPER>(arg0, 6, b"PELIPPER", b"Pelipper on Sui", b"Pelliper is Sui believer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic3qkbdsspltpi2yvze6brxertq2pzj66o27ddvwxxys4rqh4oy2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PELIPPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

