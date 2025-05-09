module 0xf5b0dbf6573a4f8f6905cbe82639591c0dc4e0ee7b68a998a2c86f61ec1907f::bluebutt {
    struct BLUEBUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBUTT>(arg0, 6, b"BLUEBUTT", b"Blue butt", b"Dive into the wild world of Blue Butt, the memecoin inspired by Matt Furie iconic Hedz. Get ready for laughs, gains, and pure degen energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadj2uvlg2quv4iswmp2f4xrnvkqevreltxmkim32gzluw6lkvzcu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEBUTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

