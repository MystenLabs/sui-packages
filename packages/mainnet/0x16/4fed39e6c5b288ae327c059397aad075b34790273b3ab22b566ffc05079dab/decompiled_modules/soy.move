module 0x164fed39e6c5b288ae327c059397aad075b34790273b3ab22b566ffc05079dab::soy {
    struct SOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOY>(arg0, 9, b"SOY", b"OMAME", b"oishiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fb974ad-e296-44b0-bf63-e9e2229a62f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

