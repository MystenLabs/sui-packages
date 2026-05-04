module 0xeee6812f2041ee8b85f628a393185dcb68cb05f9ea0aedd4ef06e93a7fefacf7::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WSUI>(arg0, 9, 0x1::string::utf8(b"WSUI"), 0x1::string::utf8(b"Wrapped SUI"), 0x1::string::utf8(b"Wrapped SUI"), 0x1::string::utf8(b"https://cryptologos.cc/logos/sui-sui-logo.png?v=040"), arg1);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WSUI>>(0x2::coin::mint<WSUI>(&mut v2, 1000000000000, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WSUI>>(0x2::coin_registry::finalize<WSUI>(v0, arg1), v3);
    }

    // decompiled from Move bytecode v7
}

