module 0x3bd9e82c31fb736e23d7c448e258fac6f10f6bb6539f916c259f7863bb1b143b::rathva {
    struct RATHVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATHVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATHVA>(arg0, 9, b"RATHVA", b"Mongo", b"Muje Aacha laga ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f95b7a1-7729-4f8f-9931-eba562305976.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATHVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATHVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

