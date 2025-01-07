module 0xfc581035b399c18c2ba511e3535c79b5775846a541981c9c0d0da186f2ad0e11::falcon {
    struct FALCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALCON>(arg0, 9, b"FALCON", x"205741564520f09f8c8a", b"FALCON is meme inspired by the spirit of adventure and freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58151e35-9525-43ea-a6a2-75c68eec61c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALCON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FALCON>>(v1);
    }

    // decompiled from Move bytecode v6
}

