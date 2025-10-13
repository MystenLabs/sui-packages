module 0x74ab2cd78dbc29c2aeb3d02f2cad86c08d9436812e7352a1444aa80126288da7::swo {
    struct MyCoin has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MyCoin> {
        let (v0, v1) = 0x2::coin_registry::new_currency<MyCoin>(arg0, 6, 0x1::string::utf8(b"SWO"), 0x1::string::utf8(b"SuimilioWorldOrder"), 0x1::string::utf8(b"The Takeover Begins."), 0x1::string::utf8(b"https://www.suimilio.world/logo.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MyCoin>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MyCoin>>(0x2::coin_registry::finalize<MyCoin>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::coin::mint<MyCoin>(&mut v2, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

