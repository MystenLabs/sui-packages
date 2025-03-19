module 0xdb088b6c5d95348a3446e8f50c6c1659040ac0fef09c14eec275a0ccb4266f12::okilatoken {
    struct OKILATOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKILATOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742373280602.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<OKILATOKEN>(arg0, 6, b"Ok", b"OkilaToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKILATOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKILATOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<OKILATOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OKILATOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

