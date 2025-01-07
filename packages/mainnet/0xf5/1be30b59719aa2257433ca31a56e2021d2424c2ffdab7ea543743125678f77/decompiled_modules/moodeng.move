module 0xf51be30b59719aa2257433ca31a56e2021d2424c2ffdab7ea543743125678f77::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"MOO DENG", x"4669727374204d4f4f2044454e47206f6e205375690a0a6d6f6f2064656e67206e6f7420667265616b696e67206f75742061626f75742074686520656c656374696f6e2c206a757374206368696c6c696e6720616e6420656e6a6f79696e672061207069656365206f662070697a7a6120e29da4efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731045207390.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

