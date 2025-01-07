module 0xdb18fd3ce00c0d8ba4a1720398639315975076d9ce3a407d0f090dccb9248d09::laozpgz_coin {
    struct LAOZPGZ_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAOZPGZ_COIN>, arg1: 0x2::coin::Coin<LAOZPGZ_COIN>) {
        0x2::coin::burn<LAOZPGZ_COIN>(arg0, arg1);
    }

    fun init(arg0: LAOZPGZ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAOZPGZ_COIN>(arg0, 9, b"LaozpgzCoin", b"Laozpgz Coin", b"lets_move task2 coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/22661987")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAOZPGZ_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAOZPGZ_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAOZPGZ_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAOZPGZ_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

