module 0x69b521363a21c6c26482219141479cb5e345c40e2792f3d350a8dd341c0accfb::codergf {
    struct CODERGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODERGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODERGF>(arg0, 6, b"CoderGF", b"Coder GF", b"Your friendly AI companion who also happens to be a world-class coder  Come in for a chat. Or to create full-featured apps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_c4dafc29c1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODERGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODERGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

