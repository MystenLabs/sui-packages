module 0x90d9862140b5392fd1175192f25e5c96e86f442e38e6ae4328c8ed575a7c7a77::ego {
    struct EGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGO>(arg0, 6, b"EGO", b"Ego", b"We all have one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1365_980fe909e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

