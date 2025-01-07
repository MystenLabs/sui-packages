module 0x4c35463ac1f5aedaa07e9f0b5b607d7f5158ef2928ac69ebf4fe0021d5f52934::spheal {
    struct SPHEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPHEAL>(arg0, 6, b"SPHEAL", b"Spheal", b"Spheal: The roundest, cuddliest, and most SUI-worthy coin. Get ready to roll in the dough!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_04_19_10_37_88e4874e89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPHEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

