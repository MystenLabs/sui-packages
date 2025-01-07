module 0xf538975c0c596b12ff99722be77a834305d9bc6e3388f5dc7d36d854ed9c259b::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"COMMUNITY TAKE OVER", x"436f6d6d756e6974792054616b656f766572202843544f290a0a7469726564206f6620656d7074792070726f6d697365732c207275672070756c6c732c20616e64206578706c6f697461746976652070726163746963657320696e207468652063727970746f2073706163652e2043544f206973206d6f7265207468616e206120746f6b656ee280946974e28099732061206d6f76656d656e742e20436f6d65206a6f696e207573206173207765206275696c64206120636f6d6d756e6974792074686174206861732066756e2c2062757420616c736f20636f6e747269627574657320746f205355492e204c657473204d4f564521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733153697625.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

