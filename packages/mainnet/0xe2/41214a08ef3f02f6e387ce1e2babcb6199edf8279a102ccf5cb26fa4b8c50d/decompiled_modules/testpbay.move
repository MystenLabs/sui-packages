module 0xe241214a08ef3f02f6e387ce1e2babcb6199edf8279a102ccf5cb26fa4b8c50d::testpbay {
    struct TESTPBAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTPBAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TESTPBAY>(arg0, 9, 0x1::string::utf8(b"TESTPBAY"), 0x1::string::utf8(b"Test PredictBay Token"), 0x1::string::utf8(b"TEST DEPLOYMENT of the PredictBay token contract. This is NOT the PBAY token and carries no value; it is a mainnet rehearsal and will be abandoned. The real token is PBAY (PredictBay Token)."), 0x1::string::utf8(b"https://predictbay.io/brand/pbay-token-512.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TESTPBAY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TESTPBAY>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTPBAY>>(0x2::coin::mint<TESTPBAY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

