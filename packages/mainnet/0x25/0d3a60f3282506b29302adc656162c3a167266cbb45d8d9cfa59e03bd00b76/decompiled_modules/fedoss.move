module 0x250d3a60f3282506b29302adc656162c3a167266cbb45d8d9cfa59e03bd00b76::fedoss {
    struct FEDOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEDOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEDOSS>(arg0, 6, b"Fedoss", b"Fedosiya", b"ggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754774635933.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEDOSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEDOSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

