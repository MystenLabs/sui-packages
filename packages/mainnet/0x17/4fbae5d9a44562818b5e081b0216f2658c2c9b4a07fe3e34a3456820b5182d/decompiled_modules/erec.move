module 0x174fbae5d9a44562818b5e081b0216f2658c2c9b4a07fe3e34a3456820b5182d::erec {
    struct EREC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EREC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EREC>(arg0, 6, b"EREC", b"Erec Tremp", b"Son of trump and Executive of vice presedent trump and wel of sui chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled1058_20250119005659_0ef278621b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EREC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EREC>>(v1);
    }

    // decompiled from Move bytecode v6
}

