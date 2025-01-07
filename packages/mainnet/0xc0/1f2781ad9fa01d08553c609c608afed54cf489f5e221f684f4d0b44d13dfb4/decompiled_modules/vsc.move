module 0xc01f2781ad9fa01d08553c609c608afed54cf489f5e221f684f4d0b44d13dfb4::vsc {
    struct VSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSC>(arg0, 9, b"VSC", b"RFG", b"ZCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4510d7e-8f26-46e2-b137-5b008250b579.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

