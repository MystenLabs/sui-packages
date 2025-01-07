module 0x81db20291b489b4443394c1a81eeafaa398bfdc78b3a6a6674702eececb54c3::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"MOJO-SUI", b"HI, I'm Mojo on SUI and I'm the first illustration drawn by Matt Furie in 1985.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731421492416.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

