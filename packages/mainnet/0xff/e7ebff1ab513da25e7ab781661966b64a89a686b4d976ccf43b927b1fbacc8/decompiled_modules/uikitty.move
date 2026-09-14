module 0xffe7ebff1ab513da25e7ab781661966b64a89a686b4d976ccf43b927b1fbacc8::uikitty {
    struct UIKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<UIKITTY>(arg0, 9, 0x1::string::utf8(b"UIKITTY"), 0x1::string::utf8(b"SuiKitty"), 0x1::string::utf8(b"SuiKitty is a fun community meme coin on Sui. Fast, playful, and built for the Sui ecosystem."), 0x1::string::utf8(b"https://gateway.irys.xyz/sn6QCRORKGaGPWWAder9qS_fc28ZxZ_sf9LgpgGZEpI"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<UIKITTY>>(0x2::coin::mint<UIKITTY>(&mut v2, 1000000000000000000, arg1), @0xec4338803e4b86138e6054dcc6933eebd6e6f05af60150fa2e063f5f6e4d73d1);
        0x2::coin_registry::make_supply_fixed_init<UIKITTY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<UIKITTY>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

