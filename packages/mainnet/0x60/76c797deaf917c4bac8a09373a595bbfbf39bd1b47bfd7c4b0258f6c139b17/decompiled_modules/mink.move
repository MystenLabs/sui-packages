module 0x6076c797deaf917c4bac8a09373a595bbfbf39bd1b47bfd7c4b0258f6c139b17::mink {
    struct MINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINK>(arg0, 6, b"MINK", b"Suimink", b"Hi, I'm Suimink $MINK. I'm an ordinary white mink hiding from everyone, sounds like a cute and strange character!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731161532461.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

