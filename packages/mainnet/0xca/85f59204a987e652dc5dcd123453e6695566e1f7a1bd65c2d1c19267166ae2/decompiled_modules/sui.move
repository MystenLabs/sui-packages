module 0xca85f59204a987e652dc5dcd123453e6695566e1f7a1bd65c2d1c19267166ae2::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Sui by SuiAI", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000077579_c295e92ae3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

