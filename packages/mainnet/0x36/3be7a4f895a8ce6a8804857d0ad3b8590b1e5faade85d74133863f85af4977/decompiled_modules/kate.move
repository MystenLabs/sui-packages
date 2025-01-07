module 0x363be7a4f895a8ce6a8804857d0ad3b8590b1e5faade85d74133863f85af4977::kate {
    struct KATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATE>(arg0, 6, b"KATE", b"KITTY TATE", x"596f75206b6e6f772077686174206665656c7320626574746572207468616e206d616b696e67206d696c6c696f6e73206f6620646f6c6c6172733f20536179696e67204e4f20746f2053484942412c20504550452c205452554d50206574632e20536179207468656d20616c6c2e2e2e204675636b20796f7520534849424121204675636b20796f75205045504521204675636b20796f75205452554d50212049747320626574746572207468616e206d6f6e65792e20427574207468652062657474657220746f20646f20697320746f206d616b65206d696c6c696f6e206f6620646f6c6c617273207769746820416e6472657720244b4154452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_22_171400_82af777948.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

