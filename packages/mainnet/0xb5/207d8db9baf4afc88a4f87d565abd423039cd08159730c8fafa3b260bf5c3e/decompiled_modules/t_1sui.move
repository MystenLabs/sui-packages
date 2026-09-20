module 0xb5207d8db9baf4afc88a4f87d565abd423039cd08159730c8fafa3b260bf5c3e::t_1sui {
    struct T_1SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: T_1SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T_1SUI>(arg0, 6, 0x1::string::utf8(b"1Sui"), 0x1::string::utf8(b"1Sui"), 0x1::string::utf8(b"All the great things we could achieve with just 1 sui and a dream"), 0x1::string::utf8(b"https://www.image2url.com/r2/default/images/1789946994359-21505ef6-5634-40b3-b5de-d46183a86b88.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T_1SUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T_1SUI>>(0x2::coin_registry::finalize<T_1SUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

