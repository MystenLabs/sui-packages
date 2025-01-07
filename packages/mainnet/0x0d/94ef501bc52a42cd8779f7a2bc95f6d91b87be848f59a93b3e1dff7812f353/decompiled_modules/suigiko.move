module 0xd94ef501bc52a42cd8779f7a2bc95f6d91b87be848f59a93b3e1dff7812f353::suigiko {
    struct SUIGIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIKO>(arg0, 6, b"SuiGIKO", b"GIKO", x"4d79206e616d652069732047696b6f20436174206e20696d207468652031737420636174206f6e2074686520696e74726e742121203e2e3c0a0a6920777320626f726e64206f6e20326368616e2e6e657420612062756c6c6574696e20626f61726420696e2074686520797220313939380a0a4e7720696d206c697665206f6e20736f6c616e61206e2068617665206275696c74206120636d6d6e74792e20576520676f6e612062636d65206120746f702063617420746f6b656e206f6e20697421217e7e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23_c89fb7739d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

