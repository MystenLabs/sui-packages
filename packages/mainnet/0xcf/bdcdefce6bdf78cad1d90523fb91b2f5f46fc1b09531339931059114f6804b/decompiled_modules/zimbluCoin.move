module 0xcfbdcdefce6bdf78cad1d90523fb91b2f5f46fc1b09531339931059114f6804b::zimbluCoin {
    struct ZIMBLUCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZIMBLUCOIN>, arg1: 0x2::coin::Coin<ZIMBLUCOIN>) {
        0x2::coin::burn<ZIMBLUCOIN>(arg0, arg1);
    }

    fun init(arg0: ZIMBLUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIMBLUCOIN>(arg0, 9, b"ZIMBLUCOIN", b"ZIMBLUCOIN", b"coin create by zimblu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/94040354?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIMBLUCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIMBLUCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZIMBLUCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZIMBLUCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

