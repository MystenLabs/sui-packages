module 0x825d9f4290caff2ce5d836a7ed5f3ebe242b5001e96f72aa4c422979c4b4c20a::manauss {
    struct MANAUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANAUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAUSS>(arg0, 9, b"MANAUSS", b"Mana", b"USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54d5176f-0058-414f-897c-ea9b621f48b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

