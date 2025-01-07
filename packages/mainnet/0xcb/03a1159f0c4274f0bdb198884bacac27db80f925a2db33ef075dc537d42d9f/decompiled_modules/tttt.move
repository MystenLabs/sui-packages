module 0xcb03a1159f0c4274f0bdb198884bacac27db80f925a2db33ef075dc537d42d9f::tttt {
    struct TTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTTT>(arg0, 9, b"TTTT", b"Hhh", b"Yyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96edb4bc-5ff5-4f2a-9909-19712dd7e6d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

