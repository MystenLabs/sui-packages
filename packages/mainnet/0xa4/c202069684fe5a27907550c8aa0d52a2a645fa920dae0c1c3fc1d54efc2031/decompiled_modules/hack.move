module 0xa4c202069684fe5a27907550c8aa0d52a2a645fa920dae0c1c3fc1d54efc2031::hack {
    struct HACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACK>(arg0, 9, b"HACK", b"Hacker", x"e280a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92d521c5-bacb-4e17-8b3d-28ed7051d82a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

