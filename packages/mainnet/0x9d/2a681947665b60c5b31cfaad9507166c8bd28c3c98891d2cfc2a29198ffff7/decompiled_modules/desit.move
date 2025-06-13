module 0x9d2a681947665b60c5b31cfaad9507166c8bd28c3c98891d2cfc2a29198ffff7::desit {
    struct DESIT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DESIT>, arg1: 0x2::coin::Coin<DESIT>) {
        0x2::coin::burn<DESIT>(arg0, arg1);
    }

    fun init(arg0: DESIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESIT>(arg0, 2, b"DESIT", b"desimoe", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DESIT>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DESIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DESIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

