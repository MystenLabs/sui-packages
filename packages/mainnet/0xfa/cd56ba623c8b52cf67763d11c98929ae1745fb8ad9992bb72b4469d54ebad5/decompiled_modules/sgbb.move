module 0xfacd56ba623c8b52cf67763d11c98929ae1745fb8ad9992bb72b4469d54ebad5::sgbb {
    struct SGBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGBB>(arg0, 9, b"SGBB", b"Sugar", b"Sugar Baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bf6a232-8a47-4c7c-aa72-a311011f2f0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

