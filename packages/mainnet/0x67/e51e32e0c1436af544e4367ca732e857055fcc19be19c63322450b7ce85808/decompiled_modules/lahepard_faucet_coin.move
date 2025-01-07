module 0x67e51e32e0c1436af544e4367ca732e857055fcc19be19c63322450b7ce85808::lahepard_faucet_coin {
    struct LAHEPARD_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAHEPARD_FAUCET_COIN>, arg1: 0x2::coin::Coin<LAHEPARD_FAUCET_COIN>) {
        0x2::coin::burn<LAHEPARD_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: LAHEPARD_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAHEPARD_FAUCET_COIN>(arg0, 9, b"LAHEPARD_FAUCET", b"LAHEPARD_FAUCET", b"faucet coin defined by mqh, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169073119?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAHEPARD_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LAHEPARD_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAHEPARD_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAHEPARD_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

