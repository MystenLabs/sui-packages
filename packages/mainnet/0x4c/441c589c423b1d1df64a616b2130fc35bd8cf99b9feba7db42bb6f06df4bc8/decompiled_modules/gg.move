module 0x4c441c589c423b1d1df64a616b2130fc35bd8cf99b9feba7db42bb6f06df4bc8::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"Gold Goblin", x"54686520676f6c64656e20676f626c696e2064726f70732074686520676f6c640a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241210_170533572_02_351b3cde00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

