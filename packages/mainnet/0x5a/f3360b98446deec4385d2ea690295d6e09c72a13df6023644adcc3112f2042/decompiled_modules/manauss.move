module 0x5af3360b98446deec4385d2ea690295d6e09c72a13df6023644adcc3112f2042::manauss {
    struct MANAUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANAUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAUSS>(arg0, 9, b"MANAUSS", b"Mana", b"USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e670672-17f8-4640-9467-2c7209858f47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

