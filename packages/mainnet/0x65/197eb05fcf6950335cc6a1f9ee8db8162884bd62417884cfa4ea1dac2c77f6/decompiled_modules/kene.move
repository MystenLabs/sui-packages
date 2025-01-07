module 0x65197eb05fcf6950335cc6a1f9ee8db8162884bd62417884cfa4ea1dac2c77f6::kene {
    struct KENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENE>(arg0, 9, b"KENE", b"bddb", b"hene", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92ff0d92-2a25-423a-a84c-615ffd13f62f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

