module 0x29691d7790518d97274fb2a36c827c917a953ae64e9d1a6e1af483f720c2159d::payesh {
    struct PAYESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAYESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAYESH>(arg0, 9, b"PAYESH", b"Mori", b"just wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/328a97a4-046f-4a5e-a683-390950ab051f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAYESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAYESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

