module 0xeee6812f2041ee8b85f628a393185dcb68cb05f9ea0aedd4ef06e93a7fefacf7::wusdt {
    struct WUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WUSDT>(arg0, 9, 0x1::string::utf8(b"WUSDT"), 0x1::string::utf8(b"Wrapped USDC"), 0x1::string::utf8(b"Wrapped USDC"), 0x1::string::utf8(b"https://cryptologos.cc/logos/tether-usdt-logo.png?v=040"), arg1);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WUSDT>>(0x2::coin::mint<WUSDT>(&mut v2, 1000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUSDT>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WUSDT>>(0x2::coin_registry::finalize<WUSDT>(v0, arg1), v3);
    }

    // decompiled from Move bytecode v7
}

