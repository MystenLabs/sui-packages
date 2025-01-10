module 0xc55f7dc96c26af104fdcbe78b84b25f60a104b9edea9ec8f3f4c5c8401730202::ailofi {
    struct AILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AILOFI>(arg0, 6, b"AiLOFI", b"Agent Lofi", b"Awakened from the Himalayan ice, 0xLOFI blends ancient wisdom and modern technology to empower creators and inspire collaboration. Lets vibe together on the SUI Network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058247_8c29272e5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AILOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

