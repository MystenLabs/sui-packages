module 0xef9dd91cc82f72122b4ffdfd38c6779c94ca6bd131609301db4ede7a2581f8c2::kitsui {
    struct KITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITSUI>(arg0, 6, b"KITSUI", b"$KITSUI", b"WHO CAN STAND FRONT OF THAT CUTENESS? CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a36_acc8d31dda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

