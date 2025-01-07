module 0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin {
    struct ALWENXX_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALWENXX_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALWENXX_FAUCET_COIN>(arg0, 8, b"ALWENXX_PUBLIC", b"alwenxx Faucet coin", b"test faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ALWENXX_FAUCET_COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALWENXX_FAUCET_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALWENXX_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ALWENXX_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

