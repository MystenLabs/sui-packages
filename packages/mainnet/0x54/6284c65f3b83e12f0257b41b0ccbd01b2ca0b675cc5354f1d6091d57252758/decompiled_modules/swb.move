module 0x546284c65f3b83e12f0257b41b0ccbd01b2ca0b675cc5354f1d6091d57252758::swb {
    struct SWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWB>(arg0, 9, b"SWB", b"Strawberri", b"delicious", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f930313-f861-4aee-b7b0-a00af67b11e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

