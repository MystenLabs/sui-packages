module 0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin {
    struct MING_XX_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MING_XX_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MING_XX_FAUCET_COIN>(arg0, 8, b"MY_FAUCET_COIN", b"MING_XX_FAUCET", b"this is FAUCETCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img2.baidu.com/it/u=3094430203,904462832&fm=253&fmt=auto&app=120&f=JPEG?w=600&h=556")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MING_XX_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MING_XX_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MING_XX_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MING_XX_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

