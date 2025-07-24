module 0x4fd5da3e407742f7759f8d511351defb36f2a424f466c622fe283ea4e2b9dcd8::b_chat {
    struct B_CHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CHAT>(arg0, 9, b"bCHAT", b"bToken CHAT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

