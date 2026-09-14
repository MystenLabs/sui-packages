module 0xa7139964b08a1e02be76397498ce5f111f48441312c95e995baa57f95230c51e::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GGG>(arg0, 9, 0x1::string::utf8(b"GGG"), 0x1::string::utf8(b"ggg"), 0x1::string::utf8(b"hh"), 0x1::string::utf8(b"https://gateway.irys.xyz/MVfSZUekt0gvioJeaE5cRXA1tVRT3GsM9Eu422MO88g"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GGG>>(0x2::coin::mint<GGG>(&mut v2, 1000000000000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<GGG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GGG>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

