module 0xd93fd0b21ea7b56dc440bde1cbf0a58ec4c616c29cdf961ccca5f753abae495b::tester {
    struct TESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTER>(arg0, 6, b"TESTER", b"test", b"testtestetset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyj7idniclur5eisowpnf6gssbkoj5gkhwfch6rei7qjy7j3v7h4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

