module 0x65c1bba19e77ad8ac8e53dcbdd50b12cc20b757257c77c60f29be8e56b83888f::aicmp {
    struct AICMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AICMP>(arg0, 6, b"AICMP", b"AICMP", b"Incubating an AI project to bring more innovation to PoW mining industry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-BAEXK4X6B3hkqmEkPuyyZQ5fZUb5iZ6SaJ7a9UDnpump-98.png/type=default_350_0?v=1735610624671"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AICMP>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AICMP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICMP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

