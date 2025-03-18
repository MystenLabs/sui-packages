module 0x71b05c30518042967619ad789c9323ab9b738c18bb209635d08286def54ed144::tonxun {
    struct TONXUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONXUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742270123579.png"));
        let (v1, v2) = 0x2::coin::create_currency<TONXUN>(arg0, 6, b"TONXUN", b"TONXUN", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONXUN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONXUN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TONXUN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TONXUN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

