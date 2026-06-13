module 0x8c9b578a0eca6bd2b735fd3e8a8594e326bf07ae8b036dbcf794b11e9658717d::currency {
    struct MyCoin has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MyCoin> {
        let (v0, v1) = 0x2::coin_registry::new_currency<MyCoin>(arg0, 6, 0x1::string::utf8(b"MyCoin"), 0x1::string::utf8(b"My Coin"), 0x1::string::utf8(b"Standard Unregulated Coin"), 0x1::string::utf8(b"https://example.com/my_coin.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MyCoin>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MyCoin>>(0x2::coin_registry::finalize<MyCoin>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<MyCoin>(&mut v2, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v7
}

