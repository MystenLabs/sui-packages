module 0xda2fc638ad3eadb46f84ca7b7d19e00a98d4f8429162eb25cbbe591be6264c58::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TSUI>(arg0, 9, 0x1::string::utf8(b"TSUI"), 0x1::string::utf8(b"TestSui"), 0x1::string::utf8(b"TSUI on Sui"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TSUI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TSUI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TSUI>>(0x2::coin::mint<TSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

