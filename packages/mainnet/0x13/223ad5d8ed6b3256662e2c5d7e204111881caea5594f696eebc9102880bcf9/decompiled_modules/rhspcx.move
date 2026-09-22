module 0x13223ad5d8ed6b3256662e2c5d7e204111881caea5594f696eebc9102880bcf9::rhspcx {
    struct RHSPCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHSPCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHSPCX>(arg0, 6, b"rhSPCX", x"5370616365204578706c6f726174696f6e20546563686e6f6c6f6769657320e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's SPCX stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0x4a0e65a3eccec6dbe60ae065f2e7bb85fae35eea.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHSPCX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHSPCX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

