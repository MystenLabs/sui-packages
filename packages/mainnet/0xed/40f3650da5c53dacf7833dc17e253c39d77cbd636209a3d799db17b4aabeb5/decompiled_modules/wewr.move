module 0xed40f3650da5c53dacf7833dc17e253c39d77cbd636209a3d799db17b4aabeb5::wewr {
    struct WEWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWR>(arg0, 9, b"WEWR", b"Wr", b"Luba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3161bfef-d4fa-41e5-b24a-acec1ecc4e01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

