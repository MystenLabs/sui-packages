module 0x94f53f4c16c61b138cc0ec348497f52503d57511371fcf1b39ae47eeeff462d7::etqwer {
    struct ETQWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETQWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETQWER>(arg0, 9, b"ETQWER", b"My Token", b"My new token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ETQWER>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETQWER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETQWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

