module 0xeaddd055f2ca55a03a07119d79f67ba66aabe357c1ecb52fda84e64350295be4::piran {
    struct PIRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRAN>(arg0, 9, b"PIRAN", b"Piran Hypeee", x"4120467265616b696e67204e61756768747920506972616e686120696e2074686520537569204f6365616e20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ed19c41bc2350b3c323d5960051835dbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIRAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

