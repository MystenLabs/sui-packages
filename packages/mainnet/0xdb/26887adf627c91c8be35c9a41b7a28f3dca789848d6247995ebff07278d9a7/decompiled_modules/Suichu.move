module 0xdb26887adf627c91c8be35c9a41b7a28f3dca789848d6247995ebff07278d9a7::Suichu {
    struct SUICHU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICHU>, arg1: 0x2::coin::Coin<SUICHU>) {
        0x2::coin::burn<SUICHU>(arg0, arg1);
    }

    fun init(arg0: SUICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHU>(arg0, 2, b"CSUI", b"SUICHU", b"a fusion between suicune and pikachu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/viaydMv.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICHU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICHU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

