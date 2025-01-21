module 0xd2939957feb180f0a239dca79c902922549c4c714d038217ba2c21b859e8a189::patron {
    struct PATRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATRON>(arg0, 6, b"PATRON", b"EL PATRON", x"224f6666696369616c206368616e6e656c7320616e64206d6f72652064657461696c732077696c6c20626520616e6e6f756e6365642061667465722074686520626f6e64696e672e20436f6d65206f6e2c206c6574204164656e6979692068656172206f757220766f69636521220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023654_f1b26e9854.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

