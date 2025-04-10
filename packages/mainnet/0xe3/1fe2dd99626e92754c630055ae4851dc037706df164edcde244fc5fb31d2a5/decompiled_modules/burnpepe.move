module 0xe31fe2dd99626e92754c630055ae4851dc037706df164edcde244fc5fb31d2a5::burnpepe {
    struct BURNPEPE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<BURNPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BURNPEPE>>(arg0, arg1);
    }

    fun init(arg0: BURNPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNPEPE>(arg0, 9, b"BURNPEPE", b"Burn Pepe", b"Burn pepe sui, 100% LP will burn https://t.me/burnpepeSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BURNPEPE>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNPEPE>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURNPEPE>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BURNPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BURNPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

