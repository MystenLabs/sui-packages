module 0xba2a31b3b21776d859c9fdfe797f52b069fe8fe0961605ab093ca4eb437d2632::ripleys {
    struct RIPLEYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPLEYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPLEYS>(arg0, 9, b"ripleysSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIPLEYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPLEYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

