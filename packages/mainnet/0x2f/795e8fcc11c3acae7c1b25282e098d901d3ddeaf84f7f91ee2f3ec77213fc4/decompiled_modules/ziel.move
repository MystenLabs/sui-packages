module 0x2f795e8fcc11c3acae7c1b25282e098d901d3ddeaf84f7f91ee2f3ec77213fc4::ziel {
    struct ZIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIEL>(arg0, 9, b"ZIEL", b"Ziel Smile", b"Ziel smile paint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab5d0644-9095-4d20-a0c2-1d534c2d7bbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

