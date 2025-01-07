module 0x5bac53a545147af96071aca8a52cf14c9fba3aab83c273bb1ea3f65738ee1e41::suilion {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 6, b"SUILION", b"Sui Lion", x"536561204c696f6ee280a6537569204c696f6ee280a6697420736f756e6465642066756e6e79e280a64e6f772c206c6574e2809973206d616b65206d6f6e65792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732056403304.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

