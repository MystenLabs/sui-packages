module 0x92bd3c4befb3a4e8a8e0a0b9fba23359e8ef2c2c8003fb5af62623dc33baf3db::bebeol {
    struct BEBEOL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEBEOL>, arg1: 0x2::coin::Coin<BEBEOL>) {
        0x2::coin::burn<BEBEOL>(arg0, arg1);
    }

    fun init(arg0: BEBEOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBEOL>(arg0, 2, b"BEBEOL", b"ktoiet", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBEOL>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBEOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEBEOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEBEOL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

