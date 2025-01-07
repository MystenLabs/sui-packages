module 0xa79d49100c6b96385dcb08e836f9141e3e6da8d39df39ba982f9c0dd2c00b1ff::aglt {
    struct AGLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGLT>(arg0, 9, b"AGLT", b"AGILITY", b"AGILITY HEROS ARE THE BEST HEROS AND AGILITY COIN WILL BE THE BEST COIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/058af04b-71a8-4065-ba9e-b47b345fd7d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

