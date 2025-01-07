module 0x950b4f7add5b4ce6a8a088c631aa90062c528144cde2ac2b0381c5525e395c0d::pepsu {
    struct PEPSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSU>(arg0, 6, b"PEPSU", b"PEPSUI", b"A good fun clever play on a refreshing new coin PEPSUI is here just for the fun and play on words. Take a refreshing look at this market and enjoy this NO rug coin. UK DEV no scams no rugs no dumps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEPSUI_1_5507f5e90b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

