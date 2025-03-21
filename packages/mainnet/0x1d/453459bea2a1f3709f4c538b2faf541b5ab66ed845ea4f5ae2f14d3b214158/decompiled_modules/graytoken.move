module 0x1d453459bea2a1f3709f4c538b2faf541b5ab66ed845ea4f5ae2f14d3b214158::graytoken {
    struct GRAYTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAYTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742545298456.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<GRAYTOKEN>(arg0, 6, b"grayToken", b"grayToken", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAYTOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAYTOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<GRAYTOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRAYTOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

