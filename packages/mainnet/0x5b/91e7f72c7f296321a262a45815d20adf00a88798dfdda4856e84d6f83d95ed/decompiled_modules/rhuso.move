module 0x5b91e7f72c7f296321a262a45815d20adf00a88798dfdda4856e84d6f83d95ed::rhuso {
    struct RHUSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHUSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHUSO>(arg0, 6, b"rhUSO", x"556e6974656420537461746573204f696c2046756e6420e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's USO stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0xa30fa36db767ad9ed3f7a60fc79526fb4d56d344.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHUSO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHUSO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

