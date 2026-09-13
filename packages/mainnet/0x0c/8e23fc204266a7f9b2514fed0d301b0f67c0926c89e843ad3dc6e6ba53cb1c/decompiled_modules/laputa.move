module 0xc8e23fc204266a7f9b2514fed0d301b0f67c0926c89e843ad3dc6e6ba53cb1c::laputa {
    struct LAPUTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAPUTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LAPUTA>(arg0, 9, 0x1::string::utf8(b"LAPUTA"), 0x1::string::utf8(b"Laputa"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreifygmwlbgdrvyifwxp4od7zneac2uwyllpe6r44oe52isvbuwuvie"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<LAPUTA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LAPUTA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LAPUTA>>(0x2::coin::mint<LAPUTA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

