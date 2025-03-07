module 0x59e7076a95fcecf37fab4ca23751a229b43d4505cd795a4cb9f8fd20d35201ec::tets3 {
    struct TETS3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETS3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741359465709.png"));
        let (v1, v2) = 0x2::coin::create_currency<TETS3>(arg0, 6, b"t", b"tets3", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETS3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETS3>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TETS3>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TETS3>>(arg0);
    }

    // decompiled from Move bytecode v6
}

