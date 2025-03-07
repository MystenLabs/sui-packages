module 0xc61ca12db36cbad5ce711c637cf217d5b1ddbc3b08e8d4c59af684ce0a095b0c::tets2 {
    struct TETS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETS2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741359465709.png"));
        let (v1, v2) = 0x2::coin::create_currency<TETS2>(arg0, 6, b"t", b"tets2", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETS2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETS2>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TETS2>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TETS2>>(arg0);
    }

    // decompiled from Move bytecode v6
}

