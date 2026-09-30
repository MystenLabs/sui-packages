module 0x12548dc39e2203c6ade92d693f943d8d1561ef2cc2014f29ccbe025e9b3ecb5b::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WOJAK>(arg0, 9, untag(b"SWOJAK"), untag(b"NWojak"), untag(b"D||{\"twitter\":\"https://x.com/wojakonx\",\"website\":\"https://wojakmeme.fun/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreigugdnciabyuny332uh2qdnmzy55u3ul4tj6hlbaplpzpyuthu4gq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<WOJAK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<WOJAK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WOJAK>>(0x2::coin::mint<WOJAK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

