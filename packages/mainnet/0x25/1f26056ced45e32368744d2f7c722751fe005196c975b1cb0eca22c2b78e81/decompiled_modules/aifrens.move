module 0x251f26056ced45e32368744d2f7c722751fe005196c975b1cb0eca22c2b78e81::aifrens {
    struct AIFRENS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIFRENS>, arg1: 0x2::coin::Coin<AIFRENS>) {
        0x2::coin::burn<AIFRENS>(arg0, arg1);
    }

    fun init(arg0: AIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIFRENS>(arg0, 9, b"aifrens", b"aifrens", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/06rwH7a.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIFRENS>>(v1);
        0x2::coin::mint_and_transfer<AIFRENS>(&mut v2, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFRENS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIFRENS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIFRENS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

