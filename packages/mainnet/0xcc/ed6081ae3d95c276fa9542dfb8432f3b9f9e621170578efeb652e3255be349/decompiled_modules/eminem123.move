module 0xcced6081ae3d95c276fa9542dfb8432f3b9f9e621170578efeb652e3255be349::eminem123 {
    struct EMINEM123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMINEM123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMINEM123>(arg0, 9, b"EMINEM123", b"Eminem", b"IS great token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5030b96-fb49-4cc9-861c-5670e6fadac6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMINEM123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMINEM123>>(v1);
    }

    // decompiled from Move bytecode v6
}

