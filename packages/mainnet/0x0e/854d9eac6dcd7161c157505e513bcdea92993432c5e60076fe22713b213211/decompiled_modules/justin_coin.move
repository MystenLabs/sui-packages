module 0xe854d9eac6dcd7161c157505e513bcdea92993432c5e60076fe22713b213211::justin_coin {
    struct JUSTIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTIN_COIN>(arg0, 8, b"JCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTIN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUSTIN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JUSTIN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

