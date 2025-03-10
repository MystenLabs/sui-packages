module 0x80ff473826080491b48701ddd5a780a5182efc4bf1b4c3db4b91a3f33daaf14a::muet_faucet_coin {
    struct MUET_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUET_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUET_FAUCET_COIN>(arg0, 8, b"MUET_FAUCET_COIN", b"MUET_FAUCET_COIN", b"This is my faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/195670331?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUET_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MUET_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

