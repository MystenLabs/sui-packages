module 0xf83b4bc44974f70706e0585c66b3c5d10e88c85197c483b840079bcd135ab2a8::gdsag {
    struct GDSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSAG>(arg0, 9, b"GDSAG", b"dasgsa", b"DSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69b55391-197a-4908-bb2d-e55d6b261969.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

