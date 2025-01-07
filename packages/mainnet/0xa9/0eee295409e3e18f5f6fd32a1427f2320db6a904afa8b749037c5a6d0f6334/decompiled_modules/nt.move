module 0xa90eee295409e3e18f5f6fd32a1427f2320db6a904afa8b749037c5a6d0f6334::nt {
    struct NT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NT>(arg0, 9, b"NT", b"Natra", x"4e61747261207468c3a1692074e1bbad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d868c65-e252-4f2d-9a10-027a0461f587.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NT>>(v1);
    }

    // decompiled from Move bytecode v6
}

