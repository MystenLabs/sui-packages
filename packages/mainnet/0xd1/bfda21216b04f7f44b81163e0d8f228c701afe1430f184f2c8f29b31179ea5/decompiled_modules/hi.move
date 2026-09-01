module 0xd1bfda21216b04f7f44b81163e0d8f228c701afe1430f184f2c8f29b31179ea5::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HI>(arg0, 9, 0x1::string::utf8(b"HI"), 0x1::string::utf8(b"HI"), 0x1::string::utf8(b"HI"), 0x1::string::utf8(b"https://gateway.irys.xyz/qep_NI4kyuHt8HRXzoX-rptmJCrlRHimjgIBlvU_U7U"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HI>>(0x2::coin::mint<HI>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<HI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HI>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

