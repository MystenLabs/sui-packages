module 0xcee74a14f4cebf79ee5ce7536467b23d9010e3908300adcfde0c2e38c347a38e::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIII>(arg0, 9, b"SUIII", b"SUIII", b"Suiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"0x3326c278075b472a95560c138646fb31bbf97df90c19f7d70b59be20c2b633f2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIII>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

