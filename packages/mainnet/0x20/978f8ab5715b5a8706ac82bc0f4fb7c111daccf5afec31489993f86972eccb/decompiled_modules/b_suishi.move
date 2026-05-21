module 0x20978f8ab5715b5a8706ac82bc0f4fb7c111daccf5afec31489993f86972eccb::b_suishi {
    struct B_SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUISHI>(arg0, 9, b"bSUISHI", b"bToken SUISHI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

