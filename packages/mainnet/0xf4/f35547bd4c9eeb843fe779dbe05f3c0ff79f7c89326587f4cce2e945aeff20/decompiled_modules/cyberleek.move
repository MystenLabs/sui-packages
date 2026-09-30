module 0xf4f35547bd4c9eeb843fe779dbe05f3c0ff79f7c89326587f4cce2e945aeff20::cyberleek {
    struct CYBERLEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERLEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CYBERLEEK>(arg0, 9, untag(b"SCYBERLEEK"), untag(b"NCyberLeek"), untag(b"D||{\"twitter\":\"https://x.com/cyberleek_ar_io\",\"website\":\"https://cyberleek.ar.io/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreif3qbjn7hi6wqea27m4dgx2yz7ammdclyrmgydiyiprbgbh5eqxwy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CYBERLEEK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CYBERLEEK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CYBERLEEK>>(0x2::coin::mint<CYBERLEEK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

