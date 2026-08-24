module 0xaa8151b75e64ef9ac49aa45aaf5cf31d7e5a87994c8df38bbca6b5311fc13616::easca {
    struct EASCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EASCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EASCA>(arg0, 9, 0x1::string::utf8(b"EASCA"), 0x1::string::utf8(b"Easca"), 0x1::string::utf8(b"Public EASCA token with a fixed maximum supply of 100,000,000 EASCA."), 0x1::string::utf8(b"https://easca-website.vercel.app/easca-token-logo.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<EASCA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<EASCA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<EASCA>>(0x2::coin::mint<EASCA>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

