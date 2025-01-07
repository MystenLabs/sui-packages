module 0x38282fbd8e043ca06eb6aea92590a001860ebb0a141de01ed1f10d2359b55675::winenot {
    struct WINENOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINENOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINENOT>(arg0, 6, b"WINENOT", b"WINE NOT?", b"Because wine not?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_23_at_15_53_44_8a9b1e8186.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINENOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINENOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

