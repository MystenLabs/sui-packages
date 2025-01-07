module 0xc0cc28d0d1bf7361793f43ad9bc07e88c37168b5b326450ac3977fe9b60b109a::nsc {
    struct NSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSC>(arg0, 9, b"NSC", b"Akujiobi ", b"I'm here for a business ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd1a10a8-c98c-45c9-8be9-2687695f41e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

