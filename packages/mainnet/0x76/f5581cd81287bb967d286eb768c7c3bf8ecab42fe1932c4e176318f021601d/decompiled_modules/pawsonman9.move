module 0x76f5581cd81287bb967d286eb768c7c3bf8ecab42fe1932c4e176318f021601d::pawsonman9 {
    struct PAWSONMAN9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWSONMAN9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWSONMAN9>(arg0, 9, b"PAWSONMAN9", b"Pb23", b"About me. Boy who loves fc25", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d3b4844-fb2b-464c-9ecb-8d8252719f87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWSONMAN9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWSONMAN9>>(v1);
    }

    // decompiled from Move bytecode v6
}

