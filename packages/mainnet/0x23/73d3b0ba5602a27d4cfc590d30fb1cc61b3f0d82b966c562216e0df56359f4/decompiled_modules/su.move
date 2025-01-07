module 0x2373d3b0ba5602a27d4cfc590d30fb1cc61b3f0d82b966c562216e0df56359f4::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 6, b"SU", b"susui", x"446f6765200a4574683a2073686962612c20706570650a536f6c3a20626f6e6b2c207769660a627574205355493f205965732075207220726974652069742773205355535549202e200a4c65742773206d616b6520537569207368697420616761696e20f09f989c0a446f67650a4574683a2073686962612c20706570650a536f6c3a20626f6e6b2c207769660a627574205355493f205965732075207220726974652069742773205355535549202e0a4c65742773206d616b65205553205355206f6e20616c6c204d656d6520636f696e73204f6e636520616761696e20f09f989c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731266323580.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

