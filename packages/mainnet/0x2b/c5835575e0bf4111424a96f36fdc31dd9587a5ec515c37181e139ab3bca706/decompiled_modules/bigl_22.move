module 0x2bc5835575e0bf4111424a96f36fdc31dd9587a5ec515c37181e139ab3bca706::bigl_22 {
    struct BIGL_22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGL_22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGL_22>(arg0, 9, b"BIGL_22", b"BIGL", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8df19c75-e9a3-4504-80dc-9b4ea72b4ffa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGL_22>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGL_22>>(v1);
    }

    // decompiled from Move bytecode v6
}

