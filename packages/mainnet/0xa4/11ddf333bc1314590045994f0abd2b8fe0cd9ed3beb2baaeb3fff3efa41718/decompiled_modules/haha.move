module 0xa411ddf333bc1314590045994f0abd2b8fe0cd9ed3beb2baaeb3fff3efa41718::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAHA>, arg1: 0x2::coin::Coin<HAHA>) {
        0x2::coin::burn<HAHA>(arg0, arg1);
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 9, b"HAHA", b"HAHA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAHA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAHA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

