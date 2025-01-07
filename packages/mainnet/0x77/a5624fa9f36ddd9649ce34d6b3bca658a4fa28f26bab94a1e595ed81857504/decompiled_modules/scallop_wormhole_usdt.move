module 0x77a5624fa9f36ddd9649ce34d6b3bca658a4fa28f26bab94a1e595ed81857504::scallop_wormhole_usdt {
    struct SCALLOP_WORMHOLE_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_USDT>(arg0, 6, b"sWUSDT", b"sWUSDT", b"Scallop interest-bearing token for wormhole USDT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ymn45ikjs3sbq7y3lmgsc7uryrj3wusynqewcbbbs22ajbcru4ka.arweave.net/wxvOoUmW5Bh_G1sNIX6RxFO7UlhsCWEEIZa0BIRRpxQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

