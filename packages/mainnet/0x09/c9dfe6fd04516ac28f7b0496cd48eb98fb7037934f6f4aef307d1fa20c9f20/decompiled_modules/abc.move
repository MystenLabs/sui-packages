module 0x9c9dfe6fd04516ac28f7b0496cd48eb98fb7037934f6f4aef307d1fa20c9f20::abc {
    struct ABC has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ABC> {
        let (v0, v1) = 0x2::coin_registry::new_currency<ABC>(arg0, 8, 0x1::string::utf8(b"ABCD"), 0x1::string::utf8(b"ABCD"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<ABC>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ABC>>(0x2::coin_registry::finalize<ABC>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<ABC>(&mut v2, 999999999900000000, arg1)
    }

    // decompiled from Move bytecode v6
}

