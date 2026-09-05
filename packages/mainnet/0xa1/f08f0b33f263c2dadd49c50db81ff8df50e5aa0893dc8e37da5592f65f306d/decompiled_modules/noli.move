module 0xa1f08f0b33f263c2dadd49c50db81ff8df50e5aa0893dc8e37da5592f65f306d::noli {
    struct NOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NOLI>(arg0, 9, 0x1::string::utf8(b"NOLI"), 0x1::string::utf8(b"nolitmer"), 0x1::string::utf8(b"noli"), 0x1::string::utf8(b"https://gateway.irys.xyz/tggGzHUtQmUo-wUjygxZzD8axSHgHIq-eCZ2-PJQ24U"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOLI>>(0x2::coin::mint<NOLI>(&mut v2, 2000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<NOLI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NOLI>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

