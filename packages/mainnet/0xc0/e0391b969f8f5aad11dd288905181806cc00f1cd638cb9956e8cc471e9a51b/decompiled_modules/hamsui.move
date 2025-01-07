module 0xc0e0391b969f8f5aad11dd288905181806cc00f1cd638cb9956e8cc471e9a51b::hamsui {
    struct HAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSUI>(arg0, 6, b"Hamsui", b"Hamster on sui", b"The real hamster on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043443_07c020cc5f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

