module 0xdddb7edfa670cc71a927f87d57d727572f7f4aa46ae0f6679a1e9759ed6ab5d7::ubik {
    struct UBIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<UBIK>(arg0, 9, untag(b"SUBIK"), untag(b"Nubik"), untag(b"D||{\"website\":\"https://www.ponsfamily.com/launchpad/0x812486EAea648819853F8E372dc9f1516C7868Bd\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreidcl4ltc3ccbfyblvbmo6mzujo3hlkcxg2choltht2lry3f6ot5li"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<UBIK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<UBIK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UBIK>>(0x2::coin::mint<UBIK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

