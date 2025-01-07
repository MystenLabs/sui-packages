module 0x7f25ae4f730196b60758ef6e78c2c8e2303b4dea8011b1f4c65e87a94a461b58::mizone {
    struct MIZONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZONE>(arg0, 9, b"MIZONE", b"Mizone SUI", b"Mizone in here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4de22f1-f2c9-4006-958a-10d1b4893bfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

