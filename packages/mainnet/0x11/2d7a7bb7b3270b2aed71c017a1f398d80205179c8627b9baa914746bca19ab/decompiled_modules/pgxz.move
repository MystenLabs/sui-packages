module 0x112d7a7bb7b3270b2aed71c017a1f398d80205179c8627b9baa914746bca19ab::pgxz {
    struct PGXZ has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PGXZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<PGXZ>(arg0) + arg1 <= 90000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PGXZ>>(0x2::coin::mint<PGXZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PGXZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGXZ>(arg0, 6, b"PGXZ", b"PGXZ", b"PGXZ Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/pyth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PGXZ>>(0x2::coin::mint<PGXZ>(&mut v2, 90000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGXZ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PGXZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

