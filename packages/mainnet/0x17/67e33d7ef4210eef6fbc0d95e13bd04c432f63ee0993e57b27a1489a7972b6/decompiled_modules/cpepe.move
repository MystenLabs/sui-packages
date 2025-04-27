module 0x1767e33d7ef4210eef6fbc0d95e13bd04c432f63ee0993e57b27a1489a7972b6::cpepe {
    struct CPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn_coins(arg0: &mut 0x2::coin::TreasuryCap<CPEPE>, arg1: 0x2::coin::Coin<CPEPE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<CPEPE>(arg0, arg1);
    }

    fun init(arg0: CPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPEPE>(arg0, 9, b"cpepe", b"CPEPE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPEPE>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = &mut v2;
        mint(v4, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPEPE>>(v2, v3);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<CPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

