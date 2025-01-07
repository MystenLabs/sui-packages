module 0xd29eb5ccce0a6592b2483e5f03f35cd53216782e0c12f585902f7f2472612c04::grbg {
    struct GRBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRBG>(arg0, 9, b"GRBG", b"Garbage", b"grbr? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0a08fc9-273d-4ffe-ae99-f2702325c2fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

