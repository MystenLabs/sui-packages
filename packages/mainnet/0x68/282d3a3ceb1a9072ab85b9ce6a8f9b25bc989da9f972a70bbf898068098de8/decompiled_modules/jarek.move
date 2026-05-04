module 0x68282d3a3ceb1a9072ab85b9ce6a8f9b25bc989da9f972a70bbf898068098de8::jarek {
    struct JAREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JAREK>(arg0, 6, 0x1::string::utf8(b"JAREK"), 0x1::string::utf8(b"Jarek Coin for fun"), 0x1::string::utf8(b"jarek coin on Sui testnet network. for education usage, don't be too serious"), 0x1::string::utf8(b"https://i.pinimg.com/1200x/e9/7f/6c/e97f6c5736288494b0bf142225a319f1.jpg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<JAREK>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JAREK>>(0x2::coin_registry::finalize<JAREK>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<JAREK>>(0x2::coin::mint<JAREK>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

