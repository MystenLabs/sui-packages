module 0xe6e5a012ec20a49a3d1d57bd2b67140b96cd4d3400b9d79e541f7bdbab661f95::scallop_wormhole_usdt {
    struct SCALLOP_WORMHOLE_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_USDT>(arg0, 6, b"sWUSDT", b"sWUSDT", b"Scallop interest-bearing token for wormhole USDT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://soug2zn7zyi4fsn7jeq5dr5nhg3j6uwcbuwd2ptjyrikbg6mha2q.arweave.net/k6htZb_OEcLJv0kh0cetObafUsINLD0-acRQoJvMODU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

