module 0xba8c722af038390615096cb77276b1154bc9793d979afbfc02ca91a531428d79::cake {
    struct CAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAKE>(arg0, 9, b"CAKE", b"SuCake dApp", b"SuCake is dAPP made to make it easier and connect Sui to other mainnet blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1551863971703046146/fl3RyAXc.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAKE>(&mut v2, 280000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

