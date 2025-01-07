module 0x5f742c8f6ad351e5b7b47769de13df23d1f648f3031d32995d301eeff95441d0::dwgt {
    struct DWGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWGT>(arg0, 6, b"DWGT", b"Dumb Ways To Get Rich", x"72494348455320415245204a5553542041205350494e20415741592e2e2e0a4f522041205350494e204f5554204f4620434f4e54524f4c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048507_0a698c0fe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

