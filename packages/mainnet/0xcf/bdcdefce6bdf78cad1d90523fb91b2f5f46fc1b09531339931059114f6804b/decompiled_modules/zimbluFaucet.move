module 0xcfbdcdefce6bdf78cad1d90523fb91b2f5f46fc1b09531339931059114f6804b::zimbluFaucet {
    struct ZIMBLUFAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZIMBLUFAUCET>, arg1: 0x2::coin::Coin<ZIMBLUFAUCET>) {
        0x2::coin::burn<ZIMBLUFAUCET>(arg0, arg1);
    }

    fun init(arg0: ZIMBLUFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIMBLUFAUCET>(arg0, 9, b"ZIMBLUFAUCET", b"ZIMBLUFAUCET", b"faucet coin defined by zimblu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/94040354?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIMBLUFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZIMBLUFAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZIMBLUFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZIMBLUFAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

