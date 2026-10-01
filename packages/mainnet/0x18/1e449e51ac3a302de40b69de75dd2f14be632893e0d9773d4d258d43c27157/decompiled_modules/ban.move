module 0x181e449e51ac3a302de40b69de75dd2f14be632893e0d9773d4d258d43c27157::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BAN>(arg0, 9, untag(b"SBAN"), untag(b"NBreak And Reclaim"), untag(b"D||{\"website\":\"https://fomo.family/tokens/bnb/0x848e2b1cb00dc439a15b03b8c3194e7d08917777\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreih42x2lfjqt7hxwgqkx7pnhly5p2gxq2ikh3mofx4act7pn4hoi2y"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BAN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BAN>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BAN>>(0x2::coin::mint<BAN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

