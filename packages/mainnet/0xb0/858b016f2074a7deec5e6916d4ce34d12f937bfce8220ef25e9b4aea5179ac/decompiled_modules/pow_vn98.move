module 0xb0858b016f2074a7deec5e6916d4ce34d12f937bfce8220ef25e9b4aea5179ac::pow_vn98 {
    struct POW_VN98 has drop {
        dummy_field: bool,
    }

    fun init(arg0: POW_VN98, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POW_VN98>(arg0, 9, b"POW_VN98", b"Poodle", b"poodle is a cute dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f38f178d-581c-4c74-bb9e-bda968e5490c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POW_VN98>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POW_VN98>>(v1);
    }

    // decompiled from Move bytecode v6
}

