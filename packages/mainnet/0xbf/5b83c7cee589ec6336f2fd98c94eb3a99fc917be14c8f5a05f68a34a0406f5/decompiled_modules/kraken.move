module 0xbf5b83c7cee589ec6336f2fd98c94eb3a99fc917be14c8f5a05f68a34a0406f5::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KRAKEN>(arg0, 9, untag(b"SKRAKEN"), untag(b"NKRAKEN"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreicyinnbdr2psj2eukwn6766g2zfbh2jusr65siblsotnwnngvlpm4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<KRAKEN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<KRAKEN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KRAKEN>>(0x2::coin::mint<KRAKEN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

