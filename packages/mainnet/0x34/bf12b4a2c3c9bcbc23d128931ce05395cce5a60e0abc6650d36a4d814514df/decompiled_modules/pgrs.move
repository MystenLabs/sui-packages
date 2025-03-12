module 0x34bf12b4a2c3c9bcbc23d128931ce05395cce5a60e0abc6650d36a4d814514df::pgrs {
    struct PGRS has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PGRS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<PGRS>(arg0) + arg1 <= 10000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PGRS>>(0x2::coin::mint<PGRS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PGRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGRS>(arg0, 6, b"PGRS", b"PGRS", b"PGRS Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/pyth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PGRS>>(0x2::coin::mint<PGRS>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGRS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PGRS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

