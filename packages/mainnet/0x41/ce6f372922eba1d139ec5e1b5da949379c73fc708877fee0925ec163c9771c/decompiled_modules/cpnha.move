module 0x41ce6f372922eba1d139ec5e1b5da949379c73fc708877fee0925ec163c9771c::cpnha {
    struct CPNHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPNHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPNHA>(arg0, 9, b"CPNHA", b"copynha", b"copynha copynha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3764fc9-d9da-4aa2-992e-35b5ef7a0ba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPNHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPNHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

