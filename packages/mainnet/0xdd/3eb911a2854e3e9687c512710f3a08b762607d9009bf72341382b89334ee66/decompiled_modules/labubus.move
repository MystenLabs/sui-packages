module 0xdd3eb911a2854e3e9687c512710f3a08b762607d9009bf72341382b89334ee66::labubus {
    struct LABUBUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBUS>(arg0, 6, b"Labubus", b"Suilabubus", b"la bu bu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_removebg_preview_bd2b5d0eed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABUBUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

