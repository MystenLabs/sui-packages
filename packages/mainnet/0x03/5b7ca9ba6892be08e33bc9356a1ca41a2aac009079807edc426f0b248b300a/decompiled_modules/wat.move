module 0x35b7ca9ba6892be08e33bc9356a1ca41a2aac009079807edc426f0b248b300a::wat {
    struct WAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742086169752.webp"));
        let (v1, v2) = 0x2::coin::create_currency<WAT>(arg0, 6, b"WAT", b"WAT", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAT>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<WAT>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

