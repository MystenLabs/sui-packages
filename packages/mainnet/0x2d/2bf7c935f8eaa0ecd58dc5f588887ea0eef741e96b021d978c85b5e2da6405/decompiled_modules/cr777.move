module 0x2d2bf7c935f8eaa0ecd58dc5f588887ea0eef741e96b021d978c85b5e2da6405::cr777 {
    struct CR777 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR777>(arg0, 9, b"CR777", b"Cr7", b"Butyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1505da67-6278-4e44-b45d-a2fe9463d798.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR777>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR777>>(v1);
    }

    // decompiled from Move bytecode v6
}

