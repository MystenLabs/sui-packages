module 0xf425516fd5948607e3ff74015d378b268596446ee1403b45a51fa3a977d3f7d8::suifrens {
    struct SUIFRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIFRENS>(arg0, 9, untag(b"SSUIFRENS"), untag(b"NSuiFrens"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigf55ub3kakzmewz55p4igkfjymt4ofn77s5no64hkgd3p27obzcu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUIFRENS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUIFRENS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIFRENS>>(0x2::coin::mint<SUIFRENS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

