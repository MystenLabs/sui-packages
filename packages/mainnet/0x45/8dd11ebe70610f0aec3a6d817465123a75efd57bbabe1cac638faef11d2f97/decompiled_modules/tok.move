module 0x458dd11ebe70610f0aec3a6d817465123a75efd57bbabe1cac638faef11d2f97::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOK>(arg0, 6, b"Tok", b"Tok Tok", x"6d656d65206f6e207375692061626f757420636869636b656e200a57652077696c6c207261697365206361706974616c20696e20323420686f7572732c2069662074686520626f6e64206375727665206973207374696c6c2074686572652c2077652077696c6c2070726f766964652053756920656e6f75676820746f2072656163682031303025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fc3e7d2e_1e1a_4976_a127_6685394a4cf7_3e59c62454.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

