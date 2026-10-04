module 0x4eb5a981d931d06f70da6a4319f9ff09536e51398230f5850e11191fa74bbc67::orange {
    struct ORANGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ORANGE>(arg0, 9, 0x1::string::utf8(b"ORANGE"), 0x1::string::utf8(b"Orange"), 0x1::string::utf8(x"4f72616e6765207465737420746f6b656e2e2044756d6d79206d6574616461746120e2809420746573746e65742072656865617273616c206f6e6c792e"), 0x1::string::utf8(b"https://www.knowyourproduce.com/wp-content/uploads/2022/09/orange-slices.jpg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<ORANGE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ORANGE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ORANGE>>(0x2::coin::mint<ORANGE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

