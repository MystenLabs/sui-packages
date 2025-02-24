module 0xaa9b8678f073d5df303d3e81a6802f33815c721d0d27bc50f36c2b96be5f4efd::jiangjinmou_faucet_coin {
    struct JIANGJINMOU_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIANGJINMOU_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIANGJINMOU_FAUCET_COIN>(arg0, 8, b"JIANGJINMOU_PUBLIC", b"jiangjinmou Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JIANGJINMOU_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIANGJINMOU_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JIANGJINMOU_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JIANGJINMOU_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

