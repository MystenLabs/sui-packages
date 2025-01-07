module 0xdd7c6cb7d80bf27c0e70750ffdd9fe7e1787a76bd5c7b9c6db9d85311d4aa8e1::mcsui {
    struct MCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCSUI>(arg0, 6, b"MCSUI", b"MC SUI", b"I will help you retire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_21_53_37_7ee6a3c83b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

