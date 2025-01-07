module 0x4bf08b40ff57ddb23ccbb317abea362e1921ebfd46f42664fa0ea85d83caa000::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEND>(arg0, 6, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/SEND/SEND.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

