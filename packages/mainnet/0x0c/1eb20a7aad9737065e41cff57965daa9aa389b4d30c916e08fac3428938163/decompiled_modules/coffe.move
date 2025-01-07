module 0xc1eb20a7aad9737065e41cff57965daa9aa389b4d30c916e08fac3428938163::coffe {
    struct COFFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFE>(arg0, 9, b"COFFE", b"Rhasel", b"Meme personal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8066677-9d54-45cd-8132-b97dd9591009.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COFFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

