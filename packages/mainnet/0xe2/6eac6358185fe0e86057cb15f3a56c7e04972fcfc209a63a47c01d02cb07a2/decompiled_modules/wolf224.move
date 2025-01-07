module 0xe26eac6358185fe0e86057cb15f3a56c7e04972fcfc209a63a47c01d02cb07a2::wolf224 {
    struct WOLF224 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF224, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF224>(arg0, 9, b"WOLF224", x"574f4c46f09f90ba", b"Holders become rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/802b004f-765c-457b-b7de-257eb074c90e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF224>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOLF224>>(v1);
    }

    // decompiled from Move bytecode v6
}

