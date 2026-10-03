module 0x1c82046b6e2a20abd9cd1e36862f42cddce470644314d5b3d7d506c50326376c::claudia {
    struct CLAUDIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAUDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CLAUDIA>(arg0, 9, untag(b"SCLAUDIA"), untag(b"NCLAUDIA"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreifhzw4tdeui47eh2ruxoottmst55qie7s7dzucfqp4mk56yjim6ti"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CLAUDIA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CLAUDIA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CLAUDIA>>(0x2::coin::mint<CLAUDIA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

