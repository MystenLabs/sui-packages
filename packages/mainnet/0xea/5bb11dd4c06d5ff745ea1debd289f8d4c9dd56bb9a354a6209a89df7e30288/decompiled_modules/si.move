module 0xea5bb11dd4c06d5ff745ea1debd289f8d4c9dd56bb9a354a6209a89df7e30288::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SI>(arg0, 9, untag(b"SSI"), untag(b"NSuper Iguana"), untag(b"D||{\"twitter\":\"https://x.com/SuperIguana_\",\"website\":\"https://www.superiguana.fun/\",\"telegram\":\"https://t.me/superiguanas\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiai7bs2wzrll2pxrg6jpostz4zdbvs3rml6be46zj6l3p3bmbia24"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SI>>(0x2::coin::mint<SI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

