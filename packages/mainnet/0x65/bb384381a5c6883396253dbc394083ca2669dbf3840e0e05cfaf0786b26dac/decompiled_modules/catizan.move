module 0x65bb384381a5c6883396253dbc394083ca2669dbf3840e0e05cfaf0786b26dac::catizan {
    struct CATIZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIZAN>(arg0, 9, b"CATIZAN", b"CATCAT", b"Love cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a46bc3b1-70b5-42cb-9bda-294a8303e769.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIZAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATIZAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

