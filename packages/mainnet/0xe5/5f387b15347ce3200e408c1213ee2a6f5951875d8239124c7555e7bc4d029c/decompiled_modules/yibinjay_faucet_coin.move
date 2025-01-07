module 0xe55f387b15347ce3200e408c1213ee2a6f5951875d8239124c7555e7bc4d029c::yibinjay_faucet_coin {
    struct YIBINJAY_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YIBINJAY_FAUCET_COIN>, arg1: 0x2::coin::Coin<YIBINJAY_FAUCET_COIN>) {
        0x2::coin::burn<YIBINJAY_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: YIBINJAY_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIBINJAY_FAUCET_COIN>(arg0, 9, b"YIBINJAY_FAUCET", b"YIBINJAY_FAUCET", b"YibinJay's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167294502")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIBINJAY_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YIBINJAY_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YIBINJAY_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YIBINJAY_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

