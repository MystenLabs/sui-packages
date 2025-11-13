module 0x4763602f1a0c43f9c21c4970aedc8ff1eb33d4c0971aca65031ad38dad99226a::ylds {
    struct YLDS has key {
        id: 0x2::object::UID,
    }

    public entry fun init_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2) = 0x2::coin_registry::new_currency<YLDS>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v3 = v2;
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<YLDS>>(0x2::coin::mint<YLDS>(&mut v3, arg6, arg7), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLDS>>(v3, v0);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YLDS>>(0x2::coin_registry::finalize<YLDS>(v1, arg7), v0);
    }

    // decompiled from Move bytecode v6
}

