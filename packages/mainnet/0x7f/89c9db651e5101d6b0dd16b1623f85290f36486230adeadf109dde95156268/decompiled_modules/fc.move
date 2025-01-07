module 0x7f89c9db651e5101d6b0dd16b1623f85290f36486230adeadf109dde95156268::fc {
    struct FC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FC>(arg0, 9, b"FC", b"Face ", b"The mysterious Mr. Face keeps order in this universe..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4c3a456-5c4e-41f2-a772-ac4e551a344f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FC>>(v1);
    }

    // decompiled from Move bytecode v6
}

