module 0x898b3f7cc426f079feabb2ec07303c94e2ad3fd3e70861237daeeda237ac9deb::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 9, b"PCAT", b"PACI CAT", b"CAT SUCKING A PACIFIER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0985a35c-f4b3-443e-a5e2-d4d2777207b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

