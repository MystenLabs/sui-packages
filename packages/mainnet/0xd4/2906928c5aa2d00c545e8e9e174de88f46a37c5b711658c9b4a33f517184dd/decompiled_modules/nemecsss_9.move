module 0xd42906928c5aa2d00c545e8e9e174de88f46a37c5b711658c9b4a33f517184dd::nemecsss_9 {
    struct NEMECSSS_9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMECSSS_9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMECSSS_9>(arg0, 9, b"NEMECSSS_9", b"Nemecsss", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3ea6770-60fa-4c0b-97fb-df037d8db080.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMECSSS_9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMECSSS_9>>(v1);
    }

    // decompiled from Move bytecode v6
}

