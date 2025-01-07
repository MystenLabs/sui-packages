module 0x5e4f05ba8ef877ab17d079939eb13ce0e21785da7379e00772fed6a6beeaeecb::yemachine_faucet_coin {
    struct YEMACHINE_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YEMACHINE_FAUCET_COIN>, arg1: 0x2::coin::Coin<YEMACHINE_FAUCET_COIN>) {
        0x2::coin::burn<YEMACHINE_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: YEMACHINE_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEMACHINE_FAUCET_COIN>(arg0, 9, b"YEMACHINE_FAUCET", b"YEMACHINE_FAUCET", b"yemachine's first faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167276459")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YEMACHINE_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YEMACHINE_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YEMACHINE_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YEMACHINE_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

