module 0xa0caee361a5d6a2b2f6c26d787721da0c90de408ee894702776d43419258f7d7::lyanna95_faucet_coin {
    struct LYANNA95_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LYANNA95_FAUCET_COIN>, arg1: 0x2::coin::Coin<LYANNA95_FAUCET_COIN>) {
        0x2::coin::burn<LYANNA95_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: LYANNA95_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYANNA95_FAUCET_COIN>(arg0, 9, b"LYANNA95_FAUCET", b"LYANNA95_FAUCET", b"lyanna95's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/172299107?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LYANNA95_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LYANNA95_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LYANNA95_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LYANNA95_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

