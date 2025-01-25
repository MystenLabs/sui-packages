module 0x18366e0552c53cd19da1cb90e1b5ebb123e0ca782b1719e6bd5eea221b5fc695::ewif {
    struct EWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EWIF>(arg0, 6, b"EWIF", b"Elon With Hat Official  by SuiAI", b"Elon With Hat Official Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_1_48d641339e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EWIF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWIF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

