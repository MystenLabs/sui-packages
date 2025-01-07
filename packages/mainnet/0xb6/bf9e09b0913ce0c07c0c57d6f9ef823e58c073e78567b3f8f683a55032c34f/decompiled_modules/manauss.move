module 0xb6bf9e09b0913ce0c07c0c57d6f9ef823e58c073e78567b3f8f683a55032c34f::manauss {
    struct MANAUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANAUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAUSS>(arg0, 9, b"MANAUSS", b"Mana", b"USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/beacdf07-0afc-4c60-a53b-708cf6550662.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

