module 0x9dff1c645fdafdd15d37ba988544aa08955e28fad6783c21d2b539bc216efd4e::suiceber_faucet_coin {
    struct SUICEBER_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICEBER_FAUCET_COIN>, arg1: 0x2::coin::Coin<SUICEBER_FAUCET_COIN>) {
        0x2::coin::burn<SUICEBER_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: SUICEBER_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICEBER_FAUCET_COIN>(arg0, 9, b"SUICEBER FAUCE", b"SUICEBER_FAUCET_COIN", b"Suiceber Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/182899206?v=4&size=64")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICEBER_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUICEBER_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICEBER_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICEBER_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

