module 0x25983a2f959802b82a32a772d1035530919436c3e649373b62c1d2b90957f618::m_tyu {
    struct M_TYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_TYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_TYU>(arg0, 9, b"M_TYU", b"Maxicoin ", x"41206d656d6520636f696e20f09faa99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2a72ca1-effa-4e9d-b26e-e6218efb3573.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_TYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_TYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

