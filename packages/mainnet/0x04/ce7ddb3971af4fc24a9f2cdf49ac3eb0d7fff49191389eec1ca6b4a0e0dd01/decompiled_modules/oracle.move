module 0x4ce7ddb3971af4fc24a9f2cdf49ac3eb0d7fff49191389eec1ca6b4a0e0dd01::oracle {
    struct ORACLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORACLE>(arg0, 6, b"ORACLE", b"Defi oracle  by SuiAI", b"The agent could bedescribed as 'An AI influencer specializing in decentralized finance oracles, providing insights and analysis on the latest trends and technologies in the DeFi space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000015504_3e0ebd910d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORACLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORACLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

