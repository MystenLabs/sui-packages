module 0xf64f5182edee32a9fd319f570d8f516ccaf9fb0942b7cb0e9bc82774cb82dab8::nctl {
    struct NCTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NCTL>(arg0, 9, 0x1::string::utf8(b"NCTL"), 0x1::string::utf8(b"ncatli"), 0x1::string::utf8(b"cat memme coin"), 0x1::string::utf8(b"https://gateway.irys.xyz/qA884LyFTSdiLBN19uOZxkG2gausGCci08J-oMO3frU"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NCTL>>(0x2::coin::mint<NCTL>(&mut v2, 1000000000000000000, arg1), @0xec4338803e4b86138e6054dcc6933eebd6e6f05af60150fa2e063f5f6e4d73d1);
        0x2::coin_registry::make_supply_fixed_init<NCTL>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NCTL>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

