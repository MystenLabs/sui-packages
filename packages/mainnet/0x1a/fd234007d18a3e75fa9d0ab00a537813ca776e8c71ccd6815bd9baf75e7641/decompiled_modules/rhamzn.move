module 0x1afd234007d18a3e75fa9d0ab00a537813ca776e8c71ccd6815bd9baf75e7641::rhamzn {
    struct RHAMZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHAMZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHAMZN>(arg0, 6, b"rhAMZN", x"416d617a6f6e20e280a220526f62696e686f6f6420546f6b656e20284d61656c7374726f6d2062726964676529", b"Robinhood's AMZN stock token, bridged from Robinhood Chain to Sui through LayerZero by Maelstrom. Raw units: read Robinhood's uiMultiplier for shares. Not for US persons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.robinhood.com/ncw_assets/logos/0x12f190a9f9d7d37a250758b26824b97ce941bf54.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHAMZN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHAMZN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

