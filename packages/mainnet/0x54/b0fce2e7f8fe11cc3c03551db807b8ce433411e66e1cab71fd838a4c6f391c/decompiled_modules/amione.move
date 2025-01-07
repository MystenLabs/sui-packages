module 0x54b0fce2e7f8fe11cc3c03551db807b8ce433411e66e1cab71fd838a4c6f391c::amione {
    struct AMIONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIONE>(arg0, 6, b"AMIONE", b"AMI A CUNT", b"SURELYNOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pngwing_com_41_0995c129c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMIONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

