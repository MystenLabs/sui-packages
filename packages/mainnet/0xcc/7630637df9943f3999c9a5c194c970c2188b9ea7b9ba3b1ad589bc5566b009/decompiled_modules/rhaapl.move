module 0xcc7630637df9943f3999c9a5c194c970c2188b9ea7b9ba3b1ad589bc5566b009::rhaapl {
    struct RHAAPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHAAPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHAAPL>(arg0, 6, b"rhAAPL", x"4170706c6520e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's AAPL stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0xaf3d76f1834a1d425780943c99ea8a608f8a93f9.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHAAPL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHAAPL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

