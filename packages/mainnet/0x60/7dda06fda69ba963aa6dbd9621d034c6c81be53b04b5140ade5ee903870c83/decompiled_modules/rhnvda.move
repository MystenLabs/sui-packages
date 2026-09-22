module 0x607dda06fda69ba963aa6dbd9621d034c6c81be53b04b5140ade5ee903870c83::rhnvda {
    struct RHNVDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHNVDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHNVDA>(arg0, 6, b"rhNVDA", x"4e564944494120e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's NVDA stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0xd0601ce157db5bdc3162bbac2a2c8af5320d9eec.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHNVDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHNVDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

