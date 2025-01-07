module 0x6bd7adfc5ae5a1754001377148f9b6c01bb9118aaad0b479cd9b94fe726738d5::bab {
    struct BAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAB>(arg0, 6, b"BAB", b"Bear AND Bull", b"HOLD don't SELL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_11_12_46_b097c1a28e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

