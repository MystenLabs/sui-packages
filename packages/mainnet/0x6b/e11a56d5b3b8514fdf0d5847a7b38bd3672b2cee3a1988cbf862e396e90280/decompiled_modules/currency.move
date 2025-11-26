module 0x6be11a56d5b3b8514fdf0d5847a7b38bd3672b2cee3a1988cbf862e396e90280::currency {
    struct COIN has key {
        id: 0x2::object::UID,
    }

    public entry fun init_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2) = 0x2::coin_registry::new_currency<COIN>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v3 = v2;
        let v4 = v1;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(&mut v3, arg6, arg7), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v3, v0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COIN>>(0x2::coin_registry::make_regulated<COIN>(&mut v4, true, arg7), v0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN>>(0x2::coin_registry::finalize<COIN>(v4, arg7), v0);
    }

    // decompiled from Move bytecode v6
}

