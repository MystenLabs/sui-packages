module 0xacf776a1da217ed4c04c549408159b5a9d91555177bc2d6810d76d30e96ab228::m_tyu {
    struct M_TYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_TYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_TYU>(arg0, 9, b"M_TYU", b"Maxicoin ", x"41206d656d6520636f696e20f09faa99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f79698a6-3108-4c95-b700-85f974cc7a33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_TYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_TYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

