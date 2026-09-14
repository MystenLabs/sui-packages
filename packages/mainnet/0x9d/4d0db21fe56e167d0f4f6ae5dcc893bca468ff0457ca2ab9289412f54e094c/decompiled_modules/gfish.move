module 0x9d4d0db21fe56e167d0f4f6ae5dcc893bca468ff0457ca2ab9289412f54e094c::gfish {
    struct GFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GFISH>(arg0, 9, untag(b"SGFISH"), untag(b"NGoldfish"), untag(b"DGoldfish swim in the depths of the Sui Ocean, paired with XAUM Gold. All fees are sent to reward holders."), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreicyolzeno2jxirpwr2hpje52efk4mlw4wywrfvl2wfi4cwlgbhrtq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GFISH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GFISH>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GFISH>>(0x2::coin::mint<GFISH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

