module 0xf82c0e5d375cf35dcad7c2396c055afbf1594caa213a0fb320fb36d2f3e2a191::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAUL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAUL>>(0x2::coin::mint<PAUL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 8, b"PAUL", b"PAULY", b"A coin for lovers of The PAUL Cafe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dnconsulting.dev/fictitiouspaulcafe.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PAUL>>(0x2::coin::mint<PAUL>(&mut v2, 30000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

