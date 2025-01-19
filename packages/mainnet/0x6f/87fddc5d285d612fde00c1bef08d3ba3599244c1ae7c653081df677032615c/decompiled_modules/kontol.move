module 0x6f87fddc5d285d612fde00c1bef08d3ba3599244c1ae7c653081df677032615c::kontol {
    struct KONTOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONTOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONTOL>(arg0, 9, b"KONTOL", b"KONTOLODON", b"KONTOLODON ARMY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fa2135e-0680-4073-863d-88180cec0174.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONTOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONTOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

