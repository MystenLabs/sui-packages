module 0xbb9577426e21e4ea5d14987988939bbf1c785111bf171b2c899ae0592d2380d3::levo_usd {
    struct LEVO_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEVO_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LEVO_USD>(arg0, 6, 0x1::string::utf8(b"LEVOUSD"), 0x1::string::utf8(b"Levo USD"), 0x1::string::utf8(b"Levo USD - StableLayer backed settlement asset"), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LEVO_USD>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEVO_USD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

