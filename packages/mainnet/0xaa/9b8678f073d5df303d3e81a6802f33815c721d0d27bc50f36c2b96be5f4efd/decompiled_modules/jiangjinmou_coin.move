module 0xaa9b8678f073d5df303d3e81a6802f33815c721d0d27bc50f36c2b96be5f4efd::jiangjinmou_coin {
    struct JIANGJINMOU_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JIANGJINMOU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JIANGJINMOU_COIN>>(0x2::coin::mint<JIANGJINMOU_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JIANGJINMOU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIANGJINMOU_COIN>(arg0, 8, b"JIANGJINMOU", b"JIANGJINMOU Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIANGJINMOU_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIANGJINMOU_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

