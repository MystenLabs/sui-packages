module 0x948aa00b27fbce58b5a7288acff28b845f8b5bbb214152832e3ba3267dcca2bc::mmaa666_faucet_coin {
    struct MMAA666_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MMAA666_FAUCET_COIN>, arg1: 0x2::coin::Coin<MMAA666_FAUCET_COIN>) {
        0x2::coin::burn<MMAA666_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: MMAA666_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMAA666_FAUCET_COIN>(arg0, 9, b"CRF", b"MMAA666_FAUCET_COIN", b"mmaa666 faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"wu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMAA666_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MMAA666_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MMAA666_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MMAA666_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

