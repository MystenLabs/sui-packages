module 0xeee6812f2041ee8b85f628a393185dcb68cb05f9ea0aedd4ef06e93a7fefacf7::wdeep {
    struct WDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WDEEP>(arg0, 6, 0x1::string::utf8(b"WDEEP"), 0x1::string::utf8(b"Wrapped USDC"), 0x1::string::utf8(b"Wrapped USDC"), 0x1::string::utf8(b"https://cryptologos.cc/logos/tether-usdt-logo.png?v=040"), arg1);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WDEEP>>(0x2::coin::mint<WDEEP>(&mut v2, 1000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDEEP>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WDEEP>>(0x2::coin_registry::finalize<WDEEP>(v0, arg1), v3);
    }

    // decompiled from Move bytecode v7
}

