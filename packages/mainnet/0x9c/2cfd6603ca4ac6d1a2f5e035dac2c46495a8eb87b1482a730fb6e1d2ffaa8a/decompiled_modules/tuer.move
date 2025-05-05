module 0x9c2cfd6603ca4ac6d1a2f5e035dac2c46495a8eb87b1482a730fb6e1d2ffaa8a::tuer {
    struct TUER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUER>, arg1: 0x2::coin::Coin<TUER>) {
        0x2::coin::burn<TUER>(arg0, arg1);
    }

    fun init(arg0: TUER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUER>(arg0, 2, b"TUER", b"hahatestha", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUER>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUER>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TUER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

