module 0x19a8e223300cea19ecb6ff52d4353d1bf3e1e098508202428d1dac10ce4cacaa::pn {
    struct PN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PN>(arg0, 9, b"PN", b"PnutX", b"Meme, dex and gamefi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19b14bd9-21d0-4b0d-9886-a429f90fbd7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PN>>(v1);
    }

    // decompiled from Move bytecode v6
}

