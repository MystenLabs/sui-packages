module 0xa3098b18c673dc1650ab6a603b7bf6d673c1c8d9252d399a15e362a0ceaf13c7::taco {
    struct TACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACO>(arg0, 6, b"TACO", b"Taco Trading ", x"4f6e6c7920302e32252074617269666673200a3320666f722032206f6e204d797374657279204d656174205441434f20636f6d626f207768656e20796f75206275792077697468205441434f0a446f6ee280997420636869636b656e206f7574210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748775589689.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TACO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

