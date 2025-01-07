module 0x39326425a65fbf16c45cf3cc6439305150751a46dff7ff3b7827022f5facb5d6::dtremp {
    struct DTREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTREMP>(arg0, 9, b"DTREMP", b"DnaldTremp", b"President of the United States", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdd06329-bb6f-4406-a8d2-53b601e4bd02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

