module 0x53f3e4c387902af37f813c10013f19493dfe2cace9a01c34df766b4449850a00::swo {
    struct SWO has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SWO> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SWO>(arg0, 6, 0x1::string::utf8(b"SWO"), 0x1::string::utf8(b"SuimilioWorldOrder"), 0x1::string::utf8(b"The Takeover Begins."), 0x1::string::utf8(b"https://www.suimilio.world/logo.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SWO>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SWO>>(0x2::coin_registry::finalize<SWO>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<SWO>(&mut v2, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

