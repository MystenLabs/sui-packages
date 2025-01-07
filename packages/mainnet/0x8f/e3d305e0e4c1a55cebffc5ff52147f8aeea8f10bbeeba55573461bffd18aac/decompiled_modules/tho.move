module 0x8fe3d305e0e4c1a55cebffc5ff52147f8aeea8f10bbeeba55573461bffd18aac::tho {
    struct THO has drop {
        dummy_field: bool,
    }

    fun init(arg0: THO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THO>(arg0, 6, b"THO", b"THO", b"dien mo ta o day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/suiCoinLogo.b3b77ca65ac4f170e7e075732ea93352.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

