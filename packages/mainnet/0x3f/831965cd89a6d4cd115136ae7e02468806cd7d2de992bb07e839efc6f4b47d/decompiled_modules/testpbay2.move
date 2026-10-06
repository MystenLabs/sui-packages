module 0x3f831965cd89a6d4cd115136ae7e02468806cd7d2de992bb07e839efc6f4b47d::testpbay2 {
    struct TESTPBAY2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTPBAY2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TESTPBAY2>(arg0, 9, 0x1::string::utf8(b"TESTPBAY2"), 0x1::string::utf8(b"Test PredictBay Token 2"), 0x1::string::utf8(b"TEST DEPLOYMENT of the PredictBay token contract, used to exercise multisig custody. NOT the PBAY token and carries no value. The real token is PBAY (PredictBay Token)."), 0x1::string::utf8(b"https://predictbay.io/brand/pbay-token-512.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TESTPBAY2>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TESTPBAY2>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTPBAY2>>(0x2::coin::mint<TESTPBAY2>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

