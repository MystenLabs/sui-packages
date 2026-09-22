module 0x197b6e322e6bf0df953f7e8ee6f122e14ec32a73b8605d74baa90edc1b1186ff::rhmsft {
    struct RHMSFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHMSFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHMSFT>(arg0, 6, b"rhMSFT", x"4d6963726f736f667420e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's MSFT stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0xe93237c50d904957cf27e7b1133b510c669c2e74.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHMSFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHMSFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

