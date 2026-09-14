module 0x794d8feb9ebaac842f8fa0cf0a03f101b1ed8018d01d1155675c4c52dc528b44::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SCB>(arg0, 9, untag(b"SSCB"), untag(b"NSacabam Return"), untag(b"DThe return of the legendary meme on SUI"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreif2hrnqlca3zgajkqsqlx4prtompmmkyuqjexd7teup2qzad62skm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SCB>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SCB>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCB>>(0x2::coin::mint<SCB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

