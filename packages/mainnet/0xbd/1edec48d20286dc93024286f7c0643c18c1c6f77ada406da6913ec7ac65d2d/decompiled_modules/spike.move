module 0xbd1edec48d20286dc93024286f7c0643c18c1c6f77ada406da6913ec7ac65d2d::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SPIKE>(arg0, 9, untag(b"SSPIKE"), untag(b"NSPIKE"), untag(b"D||{\"twitter\":\"https://x.com/spike_onbase\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiatknq3e2kwv672xo6m2fld5tfg4r4hbughaqcwfqtptck2uqslyi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SPIKE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SPIKE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPIKE>>(0x2::coin::mint<SPIKE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

