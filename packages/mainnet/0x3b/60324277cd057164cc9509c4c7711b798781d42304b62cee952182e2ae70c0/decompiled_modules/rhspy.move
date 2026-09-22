module 0x3b60324277cd057164cc9509c4c7711b798781d42304b62cee952182e2ae70c0::rhspy {
    struct RHSPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHSPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHSPY>(arg0, 6, b"rhSPY", x"5350445220532650203530302045544620e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's SPY stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0x117cc2133c37b721f49de2a7a74833232b3b4c0c.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHSPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHSPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

