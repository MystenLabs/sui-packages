module 0x740ebf1e33bd66b43d505bd4dd9fd0519a6038a6e2644347841f9eaa8a41ff4::camdenton {
    struct CAMDENTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMDENTON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742356199527.png"));
        let (v1, v2) = 0x2::coin::create_currency<CAMDENTON>(arg0, 6, b"CAMDENTON", b"CAMDENTON", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMDENTON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAMDENTON>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<CAMDENTON>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAMDENTON>>(arg0);
    }

    // decompiled from Move bytecode v6
}

