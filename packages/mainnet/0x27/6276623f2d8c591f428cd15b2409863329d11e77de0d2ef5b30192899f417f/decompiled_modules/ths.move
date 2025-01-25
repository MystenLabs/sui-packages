module 0x276276623f2d8c591f428cd15b2409863329d11e77de0d2ef5b30192899f417f::ths {
    struct THS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THS>(arg0, 6, b"THS", b"Tiny Hero on sui", b"Welcome to our common home!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_3168412ee7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THS>>(v1);
    }

    // decompiled from Move bytecode v6
}

