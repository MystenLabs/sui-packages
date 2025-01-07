module 0xb57ce85606b076e9346f054cc4fb8172a10e918dfca24a786a2378d9a7205103::aiforsui {
    struct AIFORSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIFORSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIFORSUI>(arg0, 9, b"AIFORSUI", b"AISui", b"Use AI in sui network , this token is Ai token and meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b02fee3a-48b5-45fa-ae08-33b01922b35e-IMG_3898.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFORSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIFORSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

