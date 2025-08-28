module 0xf7bbd4b6a8f050950f89953066248cf8800f6a61872ef681868515ff8b305946::super {
    struct SUPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER>(arg0, 9, b"SUPER", b"SUPER", b"SUPER for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPER>>(v1);
        0x2::coin::mint_and_transfer<SUPER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

