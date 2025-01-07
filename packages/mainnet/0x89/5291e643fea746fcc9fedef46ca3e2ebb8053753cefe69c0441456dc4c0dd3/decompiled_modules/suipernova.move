module 0x895291e643fea746fcc9fedef46ca3e2ebb8053753cefe69c0441456dc4c0dd3::suipernova {
    struct SUIPERNOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERNOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERNOVA>(arg0, 6, b"SUIPERNOVA", b"SUI SUPERNOVA", x"5375692d7065726e6f7661200a0a5768657265206368696c6c206d65657473206368616f732e200a0a4120636170796261726120696e2073706163652c20616e206578706c6f736976652073757065726e6f76612c20616e64206d656d657320736f20636f736d69632c2074686579276c6c206c656176652074686520756e697665727365206c61756768696e672e200a0a4275636b6c652075702069747320676f6e6e61206265206120626c6173742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_pernova_logo_a65ce5eb5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERNOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERNOVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

