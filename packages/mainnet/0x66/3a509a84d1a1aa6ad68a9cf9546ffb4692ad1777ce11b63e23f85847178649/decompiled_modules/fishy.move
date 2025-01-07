module 0x663a509a84d1a1aa6ad68a9cf9546ffb4692ad1777ce11b63e23f85847178649::fishy {
    struct FISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHY>(arg0, 6, b"FISHY", b"FISHYSUI", b"$FISHY Never Underestimte THE Power of meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241012_013542_193f397613.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

