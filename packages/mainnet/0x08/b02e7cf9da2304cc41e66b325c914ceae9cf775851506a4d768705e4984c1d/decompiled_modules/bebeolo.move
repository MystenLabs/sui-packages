module 0x8b02e7cf9da2304cc41e66b325c914ceae9cf775851506a4d768705e4984c1d::bebeolo {
    struct BEBEOLO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO>, arg1: 0x2::coin::Coin<BEBEOLO>) {
        0x2::coin::burn<BEBEOLO>(arg0, arg1);
    }

    fun init(arg0: BEBEOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBEOLO>(arg0, 2, b"BEBEOLO", b"ktoiet1", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBEOLO>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBEOLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEBEOLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

