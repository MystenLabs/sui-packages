module 0xeecb35108a402a9c158cb2300c0a92cf214811bfb11f92e6b4a4480d9487427f::buyscoin {
    struct BUYSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BUYSCOIN>(arg0, 9, 0x1::string::utf8(b"BUY"), 0x1::string::utf8(b"buyscoin"), 0x1::string::utf8(b"buyscoin on Sui"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<BUYSCOIN>>(0x2::coin::mint<BUYSCOIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYSCOIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BUYSCOIN>>(0x2::coin_registry::finalize<BUYSCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

