module 0x1cb9a3fa1b514b477a5519ff12cb189808aba3049320b6e61f92cdc5ed11f088::tdog {
    struct TDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDOG>(arg0, 6, b"TDOG", b"tdog", b"this is test dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNtPGXkP8QtduH5RvuQQ42M51NspU1kU2dK3GsHEzsdQ2")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

