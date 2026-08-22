module 0xe4fa1539a5c5a4417d5dedc5684706919191d7f65befa1393c3f9ebd856f9b42::moku {
    struct MOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOKU>(arg0, 9, 0x1::string::utf8(b"MOKU"), 0x1::string::utf8(b"moku.meme"), 0x1::string::utf8(b"MOKU is the coin of moku.meme."), 0x1::string::utf8(b"https://cdn.moku.meme/i/bbff69a8-358d-4fc6-ada8-11460739ddf2"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MOKU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MOKU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOKU>>(0x2::coin::mint<MOKU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

