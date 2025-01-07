module 0xf624cb384c546d56d8181ad5e7eabdb5e717ba1d069cf5cb3d26aed2fe2dfe9f::ewe {
    struct EWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWE>(arg0, 9, b"EWE", b"EWEW", b"nothing but meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65ddc899-cd34-4938-b7e8-f5e0b01b30cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

