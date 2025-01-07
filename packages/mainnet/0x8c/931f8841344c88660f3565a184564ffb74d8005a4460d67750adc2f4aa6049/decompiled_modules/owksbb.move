module 0x8c931f8841344c88660f3565a184564ffb74d8005a4460d67750adc2f4aa6049::owksbb {
    struct OWKSBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKSBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKSBB>(arg0, 9, b"OWKSBB", b"hsksjw", b"snnsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48c251e4-b677-4aae-baa3-4e471becdb66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKSBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKSBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

