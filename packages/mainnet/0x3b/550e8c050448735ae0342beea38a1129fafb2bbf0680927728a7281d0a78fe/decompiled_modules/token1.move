module 0x3b550e8c050448735ae0342beea38a1129fafb2bbf0680927728a7281d0a78fe::token1 {
    struct TOKEN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741948603906.png"));
        let (v1, v2) = 0x2::coin::create_currency<TOKEN1>(arg0, 6, b"token1", b"token1", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKEN1>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TOKEN1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN1>>(arg0);
    }

    // decompiled from Move bytecode v6
}

