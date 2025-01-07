module 0x7be31792d56292b1a6ef4d0e780eaa30123ccba1e6a7229eca6b5404f7f8ebab::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TESTCOIN", b"TESTCOIN", b"TEST only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bscscan.com/token/images/busdt_32.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTCOIN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

