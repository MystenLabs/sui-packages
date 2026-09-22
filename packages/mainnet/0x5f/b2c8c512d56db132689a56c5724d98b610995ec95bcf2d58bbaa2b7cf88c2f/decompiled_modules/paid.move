module 0x5fb2c8c512d56db132689a56c5724d98b610995ec95bcf2d58bbaa2b7cf88c2f::paid {
    struct PAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[b"TEST", b"TEST", b"Canary launch.", b""];
        let (v1, v2) = 0x2::coin_registry::new_currency_with_otw<PAID>(arg0, 9, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, 0)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, 1)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, 2)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, 3)), arg1);
        let v3 = v2;
        let v4 = v1;
        0x2::coin_registry::make_supply_fixed_init<PAID>(&mut v4, v3);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PAID>(v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PAID>>(0x2::coin::mint<PAID>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

