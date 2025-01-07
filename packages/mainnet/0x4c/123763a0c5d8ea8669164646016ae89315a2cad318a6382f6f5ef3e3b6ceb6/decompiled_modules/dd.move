module 0x4c123763a0c5d8ea8669164646016ae89315a2cad318a6382f6f5ef3e3b6ceb6::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD>(arg0, 9, b"DD", b"DonaldDuck", b"Meme coin at Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfa30779-b07a-474e-ae8b-9c591387576d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DD>>(v1);
    }

    // decompiled from Move bytecode v6
}

