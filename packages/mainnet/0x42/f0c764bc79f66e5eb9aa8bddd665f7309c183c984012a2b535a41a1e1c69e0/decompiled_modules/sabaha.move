module 0x42f0c764bc79f66e5eb9aa8bddd665f7309c183c984012a2b535a41a1e1c69e0::sabaha {
    struct SABAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SABAHA>(arg0, 9, 0x1::string::utf8(b"SABAHA"), 0x1::string::utf8(b"SABAHA"), 0x1::string::utf8(b"1"), 0x1::string::utf8(b"https://gateway.irys.xyz/cTlx_HNjUdMdmtMHoOgAJ_JuxEhEBLgRcu_ThqtcetU"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SABAHA>>(0x2::coin::mint<SABAHA>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<SABAHA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SABAHA>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

