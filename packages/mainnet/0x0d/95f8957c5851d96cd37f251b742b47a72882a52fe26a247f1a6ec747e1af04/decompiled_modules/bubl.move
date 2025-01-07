module 0xd95f8957c5851d96cd37f251b742b47a72882a52fe26a247f1a6ec747e1af04::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b"TurboBUBL", x"4275626c506c6f706572206973206f6e206974277320776179212047657420726561647920746f20287472792920706f702074686520627562626c65732c20636f6d706c657465205375692065636f73797374656d207461736b732c20616e642073656375726520796f75722073706f7420696e20746865206669727374204255424c44524f502120f09faba7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987002579.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

