module 0x9ec290bba30d1d21f8263f2507cbabd570c17d64e6cbe9021b947498b6c3f8e4::cheng {
    struct CHENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENG>(arg0, 6, b"CHENG", b"Cheng", b"This is the only token dedicated to Evan Cheng Founder of the Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958946946.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

