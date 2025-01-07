module 0x5aa339e7f458a8da8651c3988d179edcbdc7c5747d0e4d5decda8135c64f5c52::payesh {
    struct PAYESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAYESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAYESH>(arg0, 9, b"PAYESH", b"Mori", b"just wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b549d66-cfe3-4885-bcae-2db060653710.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAYESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAYESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

