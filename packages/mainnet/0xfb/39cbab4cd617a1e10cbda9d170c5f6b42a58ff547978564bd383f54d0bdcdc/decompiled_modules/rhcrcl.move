module 0xfb39cbab4cd617a1e10cbda9d170c5f6b42a58ff547978564bd383f54d0bdcdc::rhcrcl {
    struct RHCRCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHCRCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHCRCL>(arg0, 6, b"rhCRCL", x"436972636c6520496e7465726e65742047726f757020e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's CRCL stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0xdf0992e440dd0be65bd8439b609d6d4366bf1cb5.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHCRCL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHCRCL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

