module 0x7e24b191580e4440cd43a103cf95a17d4a96c55eb51ea3c4055f9505f8172c52::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"CTO SUIDOG", x"546865206d6f7374206f726967696e616c20616e64206261646173732024535549444f472c206d61646520666f72207468652023535549206e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250106_234313_777_0f79cbb960.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

