module 0x4389b72590c2b7567783a8bb824a48e018f5679e944c56ee2a77f2c679917560::dogelo {
    struct DOGELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGELO>(arg0, 6, b"DOGELO", b"DOGELORD", x"444f47454c4f5244202d204c65206e6f757665617520726f6920646573204d656d6520436f696e7320f09f91910a0a444f47454c4f524420657374206c65206e6f7576656175206d656d6520636f696e2072c3a9766f6c7574696f6e6e6169726520636f6ec3a77520706f757220636f6e7175c3a9726972206c6120626c6f636b636861696e20657420646f6d696e6572206c27756e69766572732063727970746f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735157969300.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGELO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGELO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

