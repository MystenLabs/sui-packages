module 0x29d25ba3e915c1158cc7da096881bf485d6b825751376ed89257717321cb73e3::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GGG>(arg0, 9, 0x1::string::utf8(b"GGG"), 0x1::string::utf8(b"ggg"), 0x1::string::utf8(b"jhjh"), 0x1::string::utf8(b"https://gateway.irys.xyz/AIZLJ7f-GqeizZZIfnBcznGjAPLcEyijzP1IIbeSt-Y"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GGG>>(0x2::coin::mint<GGG>(&mut v2, 1000000000000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<GGG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GGG>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

