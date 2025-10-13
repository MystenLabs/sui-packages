module 0x72118b52c069a7bbc2a696c461fdfe25e73263d068ef707ea2339a2c44b9cd4f::swo {
    struct TEST has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST> {
        let (v0, v1) = 0x2::coin_registry::new_currency<TEST>(arg0, 6, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"Test"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TEST>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST>>(0x2::coin_registry::finalize<TEST>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<TEST>(&mut v2, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

