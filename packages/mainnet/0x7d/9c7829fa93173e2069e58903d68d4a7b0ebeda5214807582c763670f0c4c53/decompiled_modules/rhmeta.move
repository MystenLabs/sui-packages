module 0x7d9c7829fa93173e2069e58903d68d4a7b0ebeda5214807582c763670f0c4c53::rhmeta {
    struct RHMETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHMETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHMETA>(arg0, 6, b"rhMETA", x"4d65746120506c6174666f726d7320e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's META stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0xc0d6457c16cc70d6790dd43521c899c87ce02f35.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHMETA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHMETA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

