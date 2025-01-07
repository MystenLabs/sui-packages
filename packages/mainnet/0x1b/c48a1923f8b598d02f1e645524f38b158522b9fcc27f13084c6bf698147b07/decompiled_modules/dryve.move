module 0x1bc48a1923f8b598d02f1e645524f38b158522b9fcc27f13084c6bf698147b07::dryve {
    struct DRYVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRYVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRYVE>(arg0, 4, b"Dryve", b"Testdryve 2", b"None", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRYVE>(&mut v2, 9000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRYVE>>(v2, @0xb43f1a838123ce75344461d91f48695af7d7ca91bc6da65090760e88683a066b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRYVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

