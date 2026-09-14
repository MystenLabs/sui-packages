module 0x2b2a12e939c812564338dff5c87fc8c854d20f269253510fcd668d0157e4a1d9::lgcy {
    struct LGCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LGCY>(arg0, 0, 0x1::string::utf8(b"LGCY"), 0x1::string::utf8(b"Legacy Icon Test"), 0x1::string::utf8(b"testing legacy CoinMetadata bridge for DexScreener icon fix"), 0x1::string::utf8(b"https://gateway.irys.xyz/5U1kFPBGV-Y34l2fofTQwM2FTRu5XnPnlBT5w-FMkfA"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LGCY>>(0x2::coin::mint<LGCY>(&mut v2, 1, arg1), @0xb1a93b4f54716aab7c5e3fb56986e00eb5438bdc6aeb36b1e9ec76672772304c);
        0x2::coin_registry::make_supply_fixed_init<LGCY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LGCY>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

