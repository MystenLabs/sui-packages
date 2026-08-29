module 0xdf0e0a3f4dfca0cd7a155d39a74c9d4f09dd87f3065793c14637bbc23b9b7df5::docker {
    struct DOCKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DOCKER>(arg0, 9, 0x1::string::utf8(b"DOCKER"), 0x1::string::utf8(b"DOCKER"), 0x1::string::utf8(b"DOCKER"), 0x1::string::utf8(b"https://gateway.irys.xyz/f8uNYhrNMYPKe-v-RSfhX3NwbfU-HD3ILeexF3wSUa4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOCKER>>(0x2::coin::mint<DOCKER>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<DOCKER>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DOCKER>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

