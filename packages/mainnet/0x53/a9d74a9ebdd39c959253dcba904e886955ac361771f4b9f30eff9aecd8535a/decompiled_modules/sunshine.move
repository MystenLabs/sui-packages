module 0x53a9d74a9ebdd39c959253dcba904e886955ac361771f4b9f30eff9aecd8535a::sunshine {
    struct SUNSHINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNSHINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUNSHINE>(arg0, 6, 0x1::string::utf8(b"SUNSHINE"), 0x1::string::utf8(b"Sunshine"), 0x1::string::utf8(b"Sunshine"), 0x1::string::utf8(b"https://arweave.net/ENiD2Ide09Zo80s25tDE6VGKOZlzQthv-2_d77_kGQQ"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<SUNSHINE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUNSHINE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUNSHINE>>(0x2::coin::mint<SUNSHINE>(&mut v2, 88888888888000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

