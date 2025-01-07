module 0x4cf08813756dfa7519cb480a1a1a3472b5b4ec067592a8bee0f826808d218158::tardi {
    struct TARDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDI>(arg0, 9, b"TARDI", b"Tardi", x"48692c20496d205461726469203a2920556e627265616b61626c652062792064657369676e2120456c6f6e2073656e74206d6520746f20746865206d6f6f6e2c20627574206e6f77206974e28099732074696d6520776520676f20696e746572706c616e6574617279", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeieycjagqv7xtenzxss5xkcxgeru7wql6izhzokr4ay4xdbrul4ef4.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARDI>>(v1);
        0x2::coin::mint_and_transfer<TARDI>(&mut v2, 1000000000000000000, @0xf88e734e4d12a746a56fc2e0262650a8aca0dfe46aa2522f94638088134c91d5, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

