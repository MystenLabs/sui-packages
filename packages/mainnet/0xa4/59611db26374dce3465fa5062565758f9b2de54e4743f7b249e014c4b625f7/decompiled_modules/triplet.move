module 0xa459611db26374dce3465fa5062565758f9b2de54e4743f7b249e014c4b625f7::triplet {
    struct TRIPLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIPLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TRIPLET>(arg0, 9, untag(b"STRIPLET"), untag(b"NTung Tung Tung Sahur"), untag(b"D||{\"twitter\":\"https://x.com/TripleTonpump\",\"website\":\"https://triplet.site/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreievclkce7x6sga4qlvlxq3c4rwrf6cyhhlqbgktni6arnovumqngm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TRIPLET>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TRIPLET>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRIPLET>>(0x2::coin::mint<TRIPLET>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

