module 0x29754ae0968424739a2d4523c1e39dbfd8736acf7428eacb5d72095a51f58e6::testbtc {
    struct TESTBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTBTC>(arg0, 9, b"TESTBTC", b"Test BTC", b"testooooor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTBTC>(&mut v2, 21000001000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTBTC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

