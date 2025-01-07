module 0xd21cb81371ba7daa83f5b99e03fb4f8b8cf6507b8f5038f7c7057395e9d84a58::shorses {
    struct SHORSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORSES>(arg0, 9, b"Shorses", b"Suihorses", b"BLUEMOVE LIQUIDITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHORSES>(&mut v2, 125000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORSES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHORSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

