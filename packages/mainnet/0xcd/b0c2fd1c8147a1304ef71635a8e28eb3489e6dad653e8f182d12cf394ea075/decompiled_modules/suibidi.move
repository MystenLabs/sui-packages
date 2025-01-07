module 0xcdb0c2fd1c8147a1304ef71635a8e28eb3489e6dad653e8f182d12cf394ea075::suibidi {
    struct SUIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIDI>(arg0, 6, b"SUIBIDI", b"Suibidi Toilet", b"Just suibidi toilet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sssss_removebg_preview_7a0c2616fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

