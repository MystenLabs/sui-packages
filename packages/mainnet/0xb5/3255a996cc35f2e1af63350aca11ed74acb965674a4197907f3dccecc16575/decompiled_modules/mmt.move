module 0xb53255a996cc35f2e1af63350aca11ed74acb965674a4197907f3dccecc16575::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MMT>(arg0, 9, untag(b"SMMT"), untag(b"NMMT"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreiesulsszkg6cbgjq2q5lw3bt4bgvi6i7wavnovk64iym2yha5mg3m"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MMT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MMT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MMT>>(0x2::coin::mint<MMT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

