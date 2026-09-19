module 0xe90b3dbfc15c5254d9bbc64c62cec085c7425c708f3b9ea0197fa29d9203088::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIPUMP>(arg0, 9, 0x1::string::utf8(b"SUICAT"), 0x1::string::utf8(b"Suicat"), 0x1::string::utf8(b"The Bald Cat of Sui"), 0x1::string::utf8(b"https://i.imgur.com/eXzg8r3.jpeg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<SUIPUMP>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUIPUMP>>(0x2::coin_registry::finalize<SUIPUMP>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

