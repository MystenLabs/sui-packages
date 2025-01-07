module 0x9268f9f227ff21b2a0a6d1770c8786478d8880887399d0072514ea0b6f92d8c::salman {
    struct SALMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMAN>(arg0, 9, b"SALMAN", b"SALAMANDER", b"The Salamander", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e362047f-5534-4bdf-96ba-b7f176b1b34c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

