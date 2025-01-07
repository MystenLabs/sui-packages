module 0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT {
    struct QWRDXER_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWRDXER_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWRDXER_USDT>(arg0, 6, b"QWRDXERUSDT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWRDXER_USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWRDXER_USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QWRDXER_USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QWRDXER_USDT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

