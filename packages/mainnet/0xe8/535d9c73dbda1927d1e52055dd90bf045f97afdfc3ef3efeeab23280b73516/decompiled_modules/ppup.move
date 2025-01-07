module 0xe8535d9c73dbda1927d1e52055dd90bf045f97afdfc3ef3efeeab23280b73516::ppup {
    struct PPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPUP>(arg0, 9, b"PPUP", b"PizzaPup", b"Because everyone loves dogs and pizza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f722eb1-2835-456e-8492-6a867b800c14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

