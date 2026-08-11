module 0x987a1d7655b0c4e97bde90e86aa7d2c585aa7bc35990c3f6366d2e791a440c06::dbtest {
    struct DBTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DBTEST>(arg0, 6, 0x1::string::utf8(b"DBTEST"), 0x1::string::utf8(b"Database TVL Test Token"), 0x1::string::utf8(b"Fixed-supply token for validating pool indexing and TVL calculations."), 0x1::string::utf8(b"https://dex.suidex.org/favicon.ico"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<DBTEST>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DBTEST>>(0x2::coin_registry::finalize<DBTEST>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DBTEST>>(0x2::coin::mint<DBTEST>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

