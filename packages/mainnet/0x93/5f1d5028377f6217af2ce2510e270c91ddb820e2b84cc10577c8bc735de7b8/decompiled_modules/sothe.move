module 0x935f1d5028377f6217af2ce2510e270c91ddb820e2b84cc10577c8bc735de7b8::sothe {
    struct SOTHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTHE>(arg0, 9, b"SOTHE", b"sothe", b"SOTHEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d77554fc-cc13-47ef-b503-16587ab7f431.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOTHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

