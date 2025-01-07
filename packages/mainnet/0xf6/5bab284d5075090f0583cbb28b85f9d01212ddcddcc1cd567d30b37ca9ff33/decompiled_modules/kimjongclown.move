module 0xf65bab284d5075090f0583cbb28b85f9d01212ddcddcc1cd567d30b37ca9ff33::kimjongclown {
    struct KIMJONGCLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMJONGCLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMJONGCLOWN>(arg0, 6, b"KIMJONGCLOWN", b"$KIM JONG CLOWN", b"just funny meme of kim jong un for making sui happiness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/280ea026e29067578104cdf9407f5798_404d082e96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMJONGCLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMJONGCLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

