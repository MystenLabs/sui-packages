module 0x1bc26793d413595ec6d462a44c7d46654f11caac33f33cc17ef002fc51940ae0::zuk {
    struct ZUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ZUK>(arg0, 9, untag(b"SZUK"), untag(b"NZuk"), untag(b"D||{\"website\":\"https://perpsplexity.app/zuk\",\"telegram\":\"https://t.me/perpsplexity\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihjx43czjkemqt2s5d5ox3svc7rn2nfloetc6sezbptyv3nb3wq2y"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ZUK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ZUK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZUK>>(0x2::coin::mint<ZUK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

