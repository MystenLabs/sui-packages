module 0x8982e61a8fa7d789c0cefcefeb38503e4251125c7ee29caa2bf4a59ad624087::pjsjsjs {
    struct PJSJSJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PJSJSJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PJSJSJS>(arg0, 9, b"PJSJSJS", b"Kajajs", b"Jwjwjwj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8313f168-daea-4d9c-9e07-5640a23e519b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PJSJSJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PJSJSJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

