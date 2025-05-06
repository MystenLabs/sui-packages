module 0x6be07633098ead8444bdd3174955ecff722778b2531b76f9f46d31599a0939b7::_suits {
    struct _SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: _SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<_SUITS>(arg0, 6, b"$SUITS", b"SUITSONSUI", x"576865726520537569747327206c6567616c206472616d61206d6565747320537569277320626c6f636b636861696e207370656564e28094706f77657266756c2c20736c65656b2c20616e6420726561647920746f20646f6d696e6174652063727970746f2077697468207374796c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<_SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<_SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

