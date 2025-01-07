module 0x40e4a7845eb84c0e557fd47c0945fed98750d3093c3cdf003569119ed8c9eccc::suilormoon {
    struct SUILORMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILORMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILORMOON>(arg0, 6, b"SUILORMOON", b"Suilor Moon", b"Degen prism, make up power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.andester.com/cdn/shop/products/O1CN011RfFG0DAbRP3dOp__181102138_1200x1200.jpg?v=1559787587")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILORMOON>(&mut v2, 777777777778000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILORMOON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILORMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

