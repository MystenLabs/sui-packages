module 0x42276c2a57d7393fa457126c9a62d5c1a7c72673fece226c3ec1abc1d27cf8f8::jorgie {
    struct JORGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORGIE>(arg0, 6, b"Jorgie", b"Free Jorgie Boy", x"e2809846726565204a6f7267696520426f79e280993a2044616c6c617320696e666c75656e63657220706c6561647320666f722068657220706574206d6f6e6b6579206261636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731574661564.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JORGIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORGIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

