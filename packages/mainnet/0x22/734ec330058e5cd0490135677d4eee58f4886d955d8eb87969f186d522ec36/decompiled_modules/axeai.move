module 0x22734ec330058e5cd0490135677d4eee58f4886d955d8eb87969f186d522ec36::axeai {
    struct AXEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXEAI>(arg0, 6, b"AXEAI", b"Axelar AI", b"Axelar AI Interchain Intelligence Powered by Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib7p4rt3nqx75vwaf7w2466aqzbglpis2c2xuccejogn3y5nm57lu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AXEAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

