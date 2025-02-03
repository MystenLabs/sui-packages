module 0xb331d2ba4692ca70f96a345b746b7d10085453c0520cdb47b32cc1cc1d1716a4::stem {
    struct STEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEM>(arg0, 6, b"STEM", b"SUISTEM", b"Advanced AI-driven ecosystem designed to revolutionize how traders interact with the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/static_stem_158e3d916a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

