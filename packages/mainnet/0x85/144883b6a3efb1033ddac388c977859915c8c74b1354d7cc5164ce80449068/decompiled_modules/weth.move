module 0x85144883b6a3efb1033ddac388c977859915c8c74b1354d7cc5164ce80449068::weth {
    struct WETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETH>(arg0, 9, b"WETH", b"Wrapped Ether", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

