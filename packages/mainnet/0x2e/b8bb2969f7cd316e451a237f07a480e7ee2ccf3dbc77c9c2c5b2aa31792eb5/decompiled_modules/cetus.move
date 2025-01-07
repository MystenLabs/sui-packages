module 0x2eb8bb2969f7cd316e451a237f07a480e7ee2ccf3dbc77c9c2c5b2aa31792eb5::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"CETUS", b"CetusZone", b"Cetus is a pioneer DEX and concentrated liquidity protocol built on the Sui and Aptos blockchain. The mission of Cetus is building a powerful and flexible underlying liquidity network to make trading easier for any users and assets. It focuses on delivering the best trading experience and superior liquidity efficiency to DeFi users through the process of building its concentrated liquidity protocol and a series of affiliate interoperable functional modules", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DT_n5w_Da_400x400_f0a4119d27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

