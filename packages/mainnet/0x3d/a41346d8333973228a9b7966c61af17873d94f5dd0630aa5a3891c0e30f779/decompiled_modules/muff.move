module 0x3da41346d8333973228a9b7966c61af17873d94f5dd0630aa5a3891c0e30f779::muff {
    struct MUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUFF>(arg0, 6, b"MUFF", b"MISTER MUFFINS", b"Hi, I'm Mister Miggles best friend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Muffin_7ee05fd645.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

