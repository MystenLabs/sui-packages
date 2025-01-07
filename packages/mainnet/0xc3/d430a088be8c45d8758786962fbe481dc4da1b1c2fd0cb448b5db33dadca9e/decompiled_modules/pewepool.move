module 0xc3d430a088be8c45d8758786962fbe481dc4da1b1c2fd0cb448b5db33dadca9e::pewepool {
    struct PEWEPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWEPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWEPOOL>(arg0, 9, b"PEWEPOOL", b"PEWE", b"No Run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/977a3718-2354-45d5-8f85-38615a84f734.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWEPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEWEPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

