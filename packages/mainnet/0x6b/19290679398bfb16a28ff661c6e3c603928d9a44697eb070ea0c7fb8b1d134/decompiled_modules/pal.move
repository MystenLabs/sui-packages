module 0x6b19290679398bfb16a28ff661c6e3c603928d9a44697eb070ea0c7fb8b1d134::pal {
    struct PAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAL>(arg0, 9, b"PAL", b"Palestine ", b"From river to the sea Palestine will be free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e37c7c5-fc9b-4896-a990-338a62ae9909.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

