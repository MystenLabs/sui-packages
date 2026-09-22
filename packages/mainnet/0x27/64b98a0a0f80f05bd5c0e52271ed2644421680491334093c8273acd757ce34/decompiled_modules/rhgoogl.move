module 0x2764b98a0a0f80f05bd5c0e52271ed2644421680491334093c8273acd757ce34::rhgoogl {
    struct RHGOOGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHGOOGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHGOOGL>(arg0, 6, b"rhGOOGL", x"416c70686162657420436c617373204120e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's GOOGL stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0x2e0847e8910a9732eb3fb1bb4b70a580adad4fe3.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHGOOGL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHGOOGL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

