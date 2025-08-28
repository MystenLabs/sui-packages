module 0x3c6cee7a61e9139fdc237da4317c84e800a25b6d432940a1db4a0612492b9444::usdoge {
    struct USDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDOGE>(arg0, 0, b"USDOGE", b"USDOGE", b"USDOEG for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDOGE>>(v1);
        0x2::coin::mint_and_transfer<USDOGE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

