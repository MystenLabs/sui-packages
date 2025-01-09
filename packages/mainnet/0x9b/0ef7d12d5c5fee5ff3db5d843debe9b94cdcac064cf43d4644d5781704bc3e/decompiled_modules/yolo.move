module 0x9b0ef7d12d5c5fee5ff3db5d843debe9b94cdcac064cf43d4644d5781704bc3e::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 6, b"YOLO", b"Sui YOLO", b"The official token of Sui YOLO Bot, Sui's premier volume & Rank Booster. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736392828197.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

