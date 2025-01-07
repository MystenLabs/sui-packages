module 0x6577946a30696f0fe35c2d5ccf0e877dd57f39bcabd92dc6e18fa8a64ce46111::timus {
    struct TIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMUS>(arg0, 6, b"TIMUS", b"hoptimus prime", b"The secret to life is to fall 7 times and get up 8 times", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/timus_ae541e1046.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

