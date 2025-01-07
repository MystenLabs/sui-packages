module 0x2d307781899244242a77624b1571b170aaa1f9e41e8fe0035286c4b6ec923a64::moeng {
    struct MOENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOENG>(arg0, 9, b"MOENG", b"MOEW", b"MOENGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c3d4010-40e8-4153-a87a-9945474d34f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

