module 0x4f0b9e31d86eae76ef8f058f9d9ef4eef5766c42394a796d085291fca05a22bd::ishi {
    struct ISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHI>(arg0, 6, b"ISHI", b"Sekishuken Sui", b"Ishi features the iconic shiba inu dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000244_10bd868c4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

