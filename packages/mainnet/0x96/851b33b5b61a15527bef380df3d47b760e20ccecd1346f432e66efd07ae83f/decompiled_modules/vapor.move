module 0x96851b33b5b61a15527bef380df3d47b760e20ccecd1346f432e66efd07ae83f::vapor {
    struct VAPOR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VAPOR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VAPOR>>(0x2::coin::mint<VAPOR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VAPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOR>(arg0, 6, b"VAPOR", b"Vaporware", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/JqQcpVK/favicon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAPOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VAPOR>>(0x2::coin::mint<VAPOR>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

