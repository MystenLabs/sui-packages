module 0x8dbac95a19bdc76d34f8497f0eaf1a76d35b3016f85972a89608d04a353ba651::rhtsla {
    struct RHTSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHTSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHTSLA>(arg0, 6, b"rhTSLA", x"5465736c6120e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's TSLA stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0x322f0929c4625ed5bad873c95208d54e1c003b2d.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHTSLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHTSLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

