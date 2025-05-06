module 0x501331e2ea5fee6c5fd6a1c250b11cf9d06e0511ce9bacef5679d4d7dc992438::wang000919_faucet_coin {
    struct WANG000919_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANG000919_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANG000919_FAUCET_COIN>(arg0, 8, b"WANG000919_FAUCET_COIN", b"WANG000919_FAUCET_COIN", b"This is my fauet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/174563322")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WANG000919_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<WANG000919_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

