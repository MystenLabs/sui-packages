module 0xb45f265c9a172c8af59538b2fac6b4afb6982b1cb66fad98cef1940d379eb438::swo {
    struct SWO has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SWO> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SWO>(arg0, 6, 0x1::string::utf8(b"SWO"), 0x1::string::utf8(b"SuimilioWorldOrder"), 0x1::string::utf8(b"The Takeover Begins."), 0x1::string::utf8(b"https://www.suimilio.world/globe.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SWO>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SWO>>(0x2::coin_registry::finalize<SWO>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<SWO>(&mut v2, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

