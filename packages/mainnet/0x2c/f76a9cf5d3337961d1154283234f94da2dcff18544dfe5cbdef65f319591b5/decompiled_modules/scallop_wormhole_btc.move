module 0x2cf76a9cf5d3337961d1154283234f94da2dcff18544dfe5cbdef65f319591b5::scallop_wormhole_btc {
    struct SCALLOP_WORMHOLE_BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_WORMHOLE_BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_WORMHOLE_BTC>(arg0, 8, b"sWBTC", b"sWBTC", b"Scallop interest-bearing token for wormhole BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://vxsbyi6gqmiz6wrto5zq7d4ezq4jnyoi3jewrxuhui7bvrrkwnwa.arweave.net/reQcI8aDEZ9aM3dzD4-EzDiW4cjaSWjeh6I-GsYqs2w")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_WORMHOLE_BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_WORMHOLE_BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

