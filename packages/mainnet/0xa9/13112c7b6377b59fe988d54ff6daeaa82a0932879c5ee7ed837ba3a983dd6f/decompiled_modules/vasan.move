module 0xa913112c7b6377b59fe988d54ff6daeaa82a0932879c5ee7ed837ba3a983dd6f::vasan {
    struct VASAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VASAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VASAN>(arg0, 9, b"VASAN", b"Ttf", b"Vasan care", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d95505e1-d0f8-427b-bef2-1563a3d748e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VASAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VASAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

