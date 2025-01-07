module 0x8fca02b234fc30debf1afdf2ef2b29dcf942e0fd02c8e5f788f6acdb0e3a0167::m_c_p {
    struct M_C_P has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_C_P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_C_P>(arg0, 9, b"M_C_P", b"MCP", b"Make Crypto Fun, Probably Nothing !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1131f152-d579-4b4d-9492-9e92616015e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_C_P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_C_P>>(v1);
    }

    // decompiled from Move bytecode v6
}

