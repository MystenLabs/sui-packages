module 0x735c8cb978a6dd9058f9d2c827be70e4f617af3a2e7071399206fa41db8743ad::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 6, b"TEST2", b"TEST 2", b"TEST2 on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/c1615546-76bb-448c-b9a2-2403b4967ca3.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

