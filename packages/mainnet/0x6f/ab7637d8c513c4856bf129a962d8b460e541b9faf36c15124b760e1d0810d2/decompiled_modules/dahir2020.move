module 0x6fab7637d8c513c4856bf129a962d8b460e541b9faf36c15124b760e1d0810d2::dahir2020 {
    struct DAHIR2020 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAHIR2020, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAHIR2020>(arg0, 9, b"DAHIR2020", b"Tm", b"Tafiyar matasa a Nigeria ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a44497ea-4a17-4fd0-9f7e-36ec1f4dc616.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAHIR2020>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAHIR2020>>(v1);
    }

    // decompiled from Move bytecode v6
}

