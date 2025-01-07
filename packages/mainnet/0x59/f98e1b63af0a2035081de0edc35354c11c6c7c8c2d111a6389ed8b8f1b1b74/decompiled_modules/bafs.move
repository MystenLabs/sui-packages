module 0x59f98e1b63af0a2035081de0edc35354c11c6c7c8c2d111a6389ed8b8f1b1b74::bafs {
    struct BAFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAFS>(arg0, 6, b"BAFS", b"Bali Farm House", b"Reconnect with Nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_20_Alpaca_1a1f02bc58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

