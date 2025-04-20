module 0x45913df0afd0c1dfd4774e8d85eab6ba0dd119b046f3d0e9f1b3cb571f183235::ganeshys_faucet_coin {
    struct GANESHYS_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANESHYS_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANESHYS_FAUCET_COIN>(arg0, 8, b"ganeshys_FAUCET_COIN", b"ganeshys_FAUCET_COIN", b"This is my faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/27858108?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANESHYS_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GANESHYS_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

