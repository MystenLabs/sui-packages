module 0x3878e38991d8e611118337ead74ca8547b37f576ba7e54efbd968781ab4efc07::nmmm {
    struct NMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NMMM>(arg0, 9, 0x1::string::utf8(b"NMMM"), 0x1::string::utf8(b"nammaser"), 0x1::string::utf8(b"SuiKitty is a fun community meme coin on Sui. Fast, playful, and built for the Sui ecosystem."), 0x1::string::utf8(b"https://gateway.irys.xyz/jmIiMdQZuN6YEDsynuNuT3_CMbLymtcgdfPaHI3nRI8"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NMMM>>(0x2::coin::mint<NMMM>(&mut v2, 1000000000000000000, arg1), @0xec4338803e4b86138e6054dcc6933eebd6e6f05af60150fa2e063f5f6e4d73d1);
        0x2::coin_registry::make_supply_fixed_init<NMMM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NMMM>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

