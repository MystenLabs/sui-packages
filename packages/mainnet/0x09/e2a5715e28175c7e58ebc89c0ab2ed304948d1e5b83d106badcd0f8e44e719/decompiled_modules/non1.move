module 0x9e2a5715e28175c7e58ebc89c0ab2ed304948d1e5b83d106badcd0f8e44e719::non1 {
    struct NON1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NON1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742295622251.png"));
        let (v1, v2) = 0x2::coin::create_currency<NON1>(arg0, 6, b"NON1", b"NON1", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NON1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NON1>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<NON1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NON1>>(arg0);
    }

    // decompiled from Move bytecode v6
}

