module 0xef2501aa82205db15d93bc57eac73ce5c0649c94697f1e165ffc367435e9b7e7::atm {
    struct ATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATM>(arg0, 9, b"ATM", b"Atomi", b"Atomi trading coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ATM>(&mut v2, 1700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATM>>(v2, @0x21a4c34c3bc72c80c1efe892c2838cdec96c81a5796f0f3fa8972b317a7abd98);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATM>>(v1);
    }

    // decompiled from Move bytecode v6
}

