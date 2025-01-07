module 0x125aa9b263fd44380dab19891a535c6e582d33988c2e2cb309db4ac90fc1d893::tokenA {
    struct TOKENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKENA>(arg0, 9, b"TOKENA", b"TOKENA", b"TOKENA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TOKENA")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TOKENA>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENA>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKENA>>(v1);
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

