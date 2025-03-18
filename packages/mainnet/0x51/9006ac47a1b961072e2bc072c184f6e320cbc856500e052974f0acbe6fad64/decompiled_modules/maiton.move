module 0x519006ac47a1b961072e2bc072c184f6e320cbc856500e052974f0acbe6fad64::maiton {
    struct MAITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAITON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742270291646.png"));
        let (v1, v2) = 0x2::coin::create_currency<MAITON>(arg0, 6, b"MAITON", b"MAITON", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAITON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAITON>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MAITON>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAITON>>(arg0);
    }

    // decompiled from Move bytecode v6
}

