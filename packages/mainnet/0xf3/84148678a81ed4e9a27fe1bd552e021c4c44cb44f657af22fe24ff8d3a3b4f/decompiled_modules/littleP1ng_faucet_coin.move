module 0xf384148678a81ed4e9a27fe1bd552e021c4c44cb44f657af22fe24ff8d3a3b4f::littleP1ng_faucet_coin {
    struct LITTLEP1NG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LITTLEP1NG_FAUCET_COIN>, arg1: 0x2::coin::Coin<LITTLEP1NG_FAUCET_COIN>) {
        0x2::coin::burn<LITTLEP1NG_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: LITTLEP1NG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLEP1NG_FAUCET_COIN>(arg0, 9, b"LITTLEP1NG_FAUCET", b"LITTLEP1NG_FAUCET", b"faucet coin defined by ping, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169317857")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LITTLEP1NG_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LITTLEP1NG_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LITTLEP1NG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LITTLEP1NG_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

