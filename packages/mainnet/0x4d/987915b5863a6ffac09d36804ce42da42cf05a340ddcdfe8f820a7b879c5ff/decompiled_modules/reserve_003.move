module 0x4d987915b5863a6ffac09d36804ce42da42cf05a340ddcdfe8f820a7b879c5ff::reserve_003 {
    struct RESERVE_003 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_003>, arg1: 0x2::coin::Coin<RESERVE_003>) {
        0x2::coin::burn<RESERVE_003>(arg0, arg1);
    }

    public fun dispense(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_003>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_003> {
        0x2::coin::mint<RESERVE_003>(arg0, arg1, arg2)
    }

    public entry fun dispense_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_003>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_003>>(0x2::coin::mint<RESERVE_003>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RESERVE_003, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_003>(arg0, 9, b"ALPHA", b"ALPHA Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-lzv3PMgNMj.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_003>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_003>>(v1);
    }

    // decompiled from Move bytecode v6
}

