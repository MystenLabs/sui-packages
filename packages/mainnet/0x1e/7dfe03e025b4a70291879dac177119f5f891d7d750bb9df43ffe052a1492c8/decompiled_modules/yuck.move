module 0x1e7dfe03e025b4a70291879dac177119f5f891d7d750bb9df43ffe052a1492c8::yuck {
    struct YUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUCK>(arg0, 6, b"YUCK", b"Yellow Duck", b"Yellow Duck is a community driven meme token. It is a project where web3 enthusiasts and innovators quack their way to build a decentralized survey ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123_574393f8ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

