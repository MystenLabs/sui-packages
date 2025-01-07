module 0xb0f1c73daca44429d16d41de77dc3c8a9c2b66d932100d3a025e97e530c06b12::andanxingkong_faucet_coin {
    struct ANDANXINGKONG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANDANXINGKONG_FAUCET_COIN>, arg1: 0x2::coin::Coin<ANDANXINGKONG_FAUCET_COIN>) {
        0x2::coin::burn<ANDANXINGKONG_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: ANDANXINGKONG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDANXINGKONG_FAUCET_COIN>(arg0, 9, b"ADX", b"ANDANXINGKONG_FAUCET_COIN", b"andanxingkong Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/149133275")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANDANXINGKONG_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ANDANXINGKONG_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANDANXINGKONG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANDANXINGKONG_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

