module 0xba47e5c413c49a393d0d9e39a0cf376812de2e54ddba4814660c6d3fe0e9e51d::usm {
    struct USM has drop {
        dummy_field: bool,
    }

    fun init(arg0: USM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USM>(arg0, 9, b"USM", b"Usmen", b"USM token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f19d630b-faca-4edd-91d2-591c8a897537.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USM>>(v1);
    }

    // decompiled from Move bytecode v6
}

