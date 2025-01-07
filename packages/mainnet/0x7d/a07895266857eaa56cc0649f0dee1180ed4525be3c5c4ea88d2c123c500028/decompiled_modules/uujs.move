module 0x7da07895266857eaa56cc0649f0dee1180ed4525be3c5c4ea88d2c123c500028::uujs {
    struct UUJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUJS>(arg0, 9, b"UUJS", b"Kjha", b"Jjjs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23c44362-62ad-438d-a35c-a917083dc584.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UUJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

