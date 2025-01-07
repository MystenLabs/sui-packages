module 0x64b1a68c833f947879e158d05850f0e8f695d6024125c93f45cebb9dedce4599::ishaq {
    struct ISHAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHAQ>(arg0, 9, b"ISHAQ", b"Wellshi ", b"Great project for all we've users ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bfcf511-cbea-46f6-9adb-492f16b6ada6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISHAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

