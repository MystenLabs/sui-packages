module 0x4154d9ba3b9c86bb15d6e7b72533d2469efaecc046fa6af754184d573f0a5bba::sinu {
    struct SINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SINU>(arg0, 9, untag(b"SSINU"), untag(b"NSuper Inu"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreigmtx2nnnqp64pf7d2g57cbrig3mcgj27jd65uq2u5r73qgnomfai"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SINU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SINU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SINU>>(0x2::coin::mint<SINU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

