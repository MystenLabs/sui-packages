module 0x86ed0ec281bec4ae88212fb7caa581bb190448cadfa5e45480969771cc87fbc4::sanaa {
    struct SANAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SANAA>(arg0, 9, 0x1::string::utf8(b"SANAA"), 0x1::string::utf8(b"SANAA"), 0x1::string::utf8(b"poule"), 0x1::string::utf8(b"https://gateway.irys.xyz/c4c2vp20Jp-ILmz7QXEpPlp3l2A8JcFio0MCca0AFt0"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SANAA>>(0x2::coin::mint<SANAA>(&mut v2, 1000000000000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<SANAA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SANAA>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

