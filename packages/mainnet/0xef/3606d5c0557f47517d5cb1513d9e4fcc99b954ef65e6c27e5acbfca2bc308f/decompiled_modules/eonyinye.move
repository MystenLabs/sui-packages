module 0xef3606d5c0557f47517d5cb1513d9e4fcc99b954ef65e6c27e5acbfca2bc308f::eonyinye {
    struct EONYINYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EONYINYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EONYINYE>(arg0, 9, b"EONYINYE", b"Ehbonieh", b"It's a #wewe week", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cd08713-caf1-4430-9880-dff2410bcea5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EONYINYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EONYINYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

