module 0xae2f693ef0d2f9aaa59130d5fdfc7b8668fac6c9d875dab89bc49973f82b7f9b::tar {
    struct TAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TAR>(arg0, 9, 0x1::string::utf8(b"TAR"), 0x1::string::utf8(b"TAR"), 0x1::string::utf8(b"TAR"), 0x1::string::utf8(b"https://gateway.irys.xyz/uAH0ZDa8ftPNLCnlKm21Wx3rvMqhUxFbuHN3VDxQqks"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TAR>>(0x2::coin::mint<TAR>(&mut v2, 100000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<TAR>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TAR>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

