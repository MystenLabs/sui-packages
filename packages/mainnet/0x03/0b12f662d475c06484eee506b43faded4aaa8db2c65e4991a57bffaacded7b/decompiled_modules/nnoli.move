module 0x30b12f662d475c06484eee506b43faded4aaa8db2c65e4991a57bffaacded7b::nnoli {
    struct NNOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NNOLI>(arg0, 9, 0x1::string::utf8(b"NNOLI"), 0x1::string::utf8(b"Nnolitmere"), 0x1::string::utf8(b"SuiKitty is a fun community meme coin on Sui. Fast, playful, and built for the Sui ecosystem"), 0x1::string::utf8(b"https://gateway.irys.xyz/mBCWRiAsKlbHz0pTdO5kfG5Iar6lJOl0J6SkyTX3iFE"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NNOLI>>(0x2::coin::mint<NNOLI>(&mut v2, 1000000000000000000, arg1), @0xec4338803e4b86138e6054dcc6933eebd6e6f05af60150fa2e063f5f6e4d73d1);
        0x2::coin_registry::make_supply_fixed_init<NNOLI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NNOLI>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

