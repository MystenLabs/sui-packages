module 0xf9d41bed309e4b786bc214b5cc0907d3aa812c63faf7e89a347141b69c5f2bd4::nghia113 {
    struct NGHIA113 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGHIA113, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGHIA113>(arg0, 9, b"NGHIA113", b"Nghia", x"56e1bba5206cc3a0206368c3ad6e68", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2081727e-e476-4bf6-9d9f-2228a6d755d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGHIA113>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGHIA113>>(v1);
    }

    // decompiled from Move bytecode v6
}

