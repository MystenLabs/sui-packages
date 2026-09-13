module 0x7e0c647b60bab514751cf15525d99b5697adfbd9e03dce31d66e8a3cac9b210::sgold {
    struct SGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SGOLD>(arg0, 9, untag(b"SSGOLD"), untag(b"NSUI GOLD"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeifjt5v4er2mxtogof56zov7s7w6zzmshhlylkealgqeafejh42xam"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SGOLD>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SGOLD>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SGOLD>>(0x2::coin::mint<SGOLD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

