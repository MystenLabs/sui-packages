module 0xf6e065f3a46da23679a571609ea4681781a559979113ab3598d9b0a5f2632c20::falcon {
    struct FALCON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALCON>(arg0, 9, b"FALCON", x"205741564520f09f8c8a", b"FALCON is meme inspired by the spirit of adventure and freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8418855f-9f71-4547-9293-e2e60c221dba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALCON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FALCON>>(v1);
    }

    // decompiled from Move bytecode v6
}

