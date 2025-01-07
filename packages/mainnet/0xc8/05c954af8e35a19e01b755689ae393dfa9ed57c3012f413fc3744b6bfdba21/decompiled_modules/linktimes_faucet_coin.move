module 0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin {
    struct LINKTIMES_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LINKTIMES_FAUCET_COIN>, arg1: 0x2::coin::Coin<LINKTIMES_FAUCET_COIN>) {
        0x2::coin::burn<LINKTIMES_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: LINKTIMES_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINKTIMES_FAUCET_COIN>(arg0, 9, b"LINKTIMES_FAUCET", b"LINKTIMES_FAUCET", b"faucet coin defined by mqh, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169920582?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINKTIMES_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LINKTIMES_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LINKTIMES_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LINKTIMES_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

