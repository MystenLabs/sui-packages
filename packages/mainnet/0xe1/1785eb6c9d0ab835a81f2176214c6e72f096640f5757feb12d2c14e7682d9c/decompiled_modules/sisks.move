module 0xe11785eb6c9d0ab835a81f2176214c6e72f096640f5757feb12d2c14e7682d9c::sisks {
    struct SISKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISKS>(arg0, 9, b"SISKS", b"Akak", b"Ckdkeks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8536f11-bb32-47bc-8512-e9de0ca711e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SISKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

