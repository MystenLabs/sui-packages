module 0x9d7cb3d8311b997a6bf7c7eff227936e4c37cbf0e5923b65bd1c7ead88768263::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742300776678.png"));
        let (v1, v2) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"PUMP", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<PUMP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUMP>>(arg0);
    }

    // decompiled from Move bytecode v6
}

