module 0xd323b7037959f56724c6c8ac711d304c570c47e16f83d9a79739c10d66d2c7ad::nub {
    struct NUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUB>(arg0, 6, b"NUB", b"nubcat", b"just a silly nubcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kr8_Dia_OD_400x400_b7904ef1bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

