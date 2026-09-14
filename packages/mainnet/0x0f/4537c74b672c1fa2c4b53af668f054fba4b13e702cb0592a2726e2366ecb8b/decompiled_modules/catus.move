module 0xf4537c74b672c1fa2c4b53af668f054fba4b13e702cb0592a2726e2366ecb8b::catus {
    struct CATUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CATUS>(arg0, 9, untag(b"SCATUS"), untag(b"NCATUS"), untag(b"DCatus on sui"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiha354f4q7oz4icjsfjiceh2cdkerr346h2vjz7jeryz2w76ty7iq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CATUS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CATUS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CATUS>>(0x2::coin::mint<CATUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

