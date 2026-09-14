module 0x3d717c19c0703031753138abb0a2c5b42b09f447bd3c9806d0e5531f1e52ddf3::riptide {
    struct RIPTIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPTIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RIPTIDE>(arg0, 9, untag(b"SRIPTIDE"), untag(b"NRIP TIDE"), untag(b"DThe whirlpool that swallows wallets whole. RIP TIDE lives in the Maelstrom, one pull, one exit, one shot at swimming out rich. Fixed supply. Liquidity locked forever. No lifeguard on duty. Are you a strong swimmer?"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeig2ek22hnn6t2acgjjcwvfxcrjvrpywlffdmihlhopkmh3te2rp7u"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<RIPTIDE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<RIPTIDE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIPTIDE>>(0x2::coin::mint<RIPTIDE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

