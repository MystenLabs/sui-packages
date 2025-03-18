module 0x174abf9e0c06a768806947f74a3748ae57885e3f6ca722f99deb32bb38e28f7e::xun1 {
    struct XUN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUN1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742273630053.png"));
        let (v1, v2) = 0x2::coin::create_currency<XUN1>(arg0, 6, b"XUN1", b"XUN1", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUN1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XUN1>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<XUN1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XUN1>>(arg0);
    }

    // decompiled from Move bytecode v6
}

