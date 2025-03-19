module 0x5bc56a25242b5cf289ef2edad00919d549126d3e9935dc48ff7d4ef56af42b6e::testtesttest {
    struct TESTTESTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTESTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742377692596.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<TESTTESTTEST>(arg0, 6, b"TTT", b"TestTestTest", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTESTTEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTESTTEST>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTTESTTEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTTESTTEST>>(arg0);
    }

    // decompiled from Move bytecode v6
}

