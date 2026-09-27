module 0xe66802c94c4c0744d85e8a149150bd4b875e0c082433923b17f063a9d6fe186e::t4 {
    struct T4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<T4>(arg0, 6, 0x1::string::utf8(b"T4"), 0x1::string::utf8(b"test4"), 0x1::string::utf8(b"testingg"), 0x1::string::utf8(b"https://cdn.dexscreener.com/cms/images/mfmdae-YKRkukKz7?width=64&height=64&fit=crop&quality=95&format=auto"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<T4>>(0x2::coin_registry::finalize<T4>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

