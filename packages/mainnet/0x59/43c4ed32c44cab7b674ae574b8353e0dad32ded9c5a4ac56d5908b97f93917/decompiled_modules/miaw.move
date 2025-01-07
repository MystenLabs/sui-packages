module 0x5943c4ed32c44cab7b674ae574b8353e0dad32ded9c5a4ac56d5908b97f93917::miaw {
    struct MIAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAW>(arg0, 9, b"MIAW", b"MiawMiaw", b"Miaw miaw is meme token Miaw miaw ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3339234-5c3d-4092-8393-819765f8a153.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

