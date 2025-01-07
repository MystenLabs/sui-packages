module 0x865385988e341cf6b85f751b7bdab550c4bc704f5960371ba301a1bec9bc7c21::cto {
    struct CTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTO>(arg0, 6, b"CTO", b"COMMUNITY TAKEOVER", x"656d7074792070726f6d697365732c207275672070756c6c732c20616e64206578706c6f697461746976652070726163746963657320696e207468652063727970746f2073706163652e2043544f206973206d6f7265207468616e206120746f6b656ee280946974e28099732061206d6f76656d656e742e2041696d656420617420656d706f776572696e672074686520636f6d6d756e6974792c2043544f20666f7374657273207472616e73706172656e63792c20666169726e6573732c20616e6420636f6c6c65637469766520676f7665726e616e63652e204a6f696e20746865206d6f76656d656e742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733154189478.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

