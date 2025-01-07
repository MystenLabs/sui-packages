module 0x7b8e314814a5b758bbd6d844f139d9135508bcafcaf84d69e6eaf159a87ff7d8::SUIAIFRENS {
    struct SUIAIFRENS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIAIFRENS>, arg1: 0x2::coin::Coin<SUIAIFRENS>) {
        0x2::coin::burn<SUIAIFRENS>(arg0, arg1);
    }

    fun init(arg0: SUIAIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAIFRENS>(arg0, 2, b"aifrens", b"SUIAIFRENS", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAIFRENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAIFRENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIAIFRENS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIAIFRENS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

