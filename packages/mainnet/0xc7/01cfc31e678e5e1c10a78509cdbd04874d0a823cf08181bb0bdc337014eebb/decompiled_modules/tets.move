module 0xc701cfc31e678e5e1c10a78509cdbd04874d0a823cf08181bb0bdc337014eebb::tets {
    struct TETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741359465709.png"));
        let (v1, v2) = 0x2::coin::create_currency<TETS>(arg0, 6, b"t", b"tets", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETS>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TETS>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TETS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

