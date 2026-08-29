module 0x3091fd548a768a027d292139633d959f78c375454b8548534c4d6e928d755355::docker {
    struct DOCKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DOCKER>(arg0, 9, 0x1::string::utf8(b"DOCKER"), 0x1::string::utf8(b"DOCKER"), 0x1::string::utf8(b"1"), 0x1::string::utf8(b"https://gateway.irys.xyz/Od1SPI5eJUzmLTXJYtfOtteEf4qC_9JElIScH1dcZx0"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DOCKER>>(0x2::coin::mint<DOCKER>(&mut v2, 2000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<DOCKER>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DOCKER>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

