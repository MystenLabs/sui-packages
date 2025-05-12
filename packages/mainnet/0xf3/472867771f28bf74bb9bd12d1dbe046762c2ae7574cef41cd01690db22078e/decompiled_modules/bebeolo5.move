module 0xf3472867771f28bf74bb9bd12d1dbe046762c2ae7574cef41cd01690db22078e::bebeolo5 {
    struct BEBEOLO5 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO5>, arg1: 0x2::coin::Coin<BEBEOLO5>) {
        0x2::coin::burn<BEBEOLO5>(arg0, arg1);
    }

    fun init(arg0: BEBEOLO5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBEOLO5>(arg0, 2, b"BEBEOLO5", b"ktoiet3", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBEOLO5>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBEOLO5>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEBEOLO5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BEBEOLO5>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

