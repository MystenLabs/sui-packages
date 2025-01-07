module 0xc128bc2b1abc2807cc13a45ebfaf5202a5817596c2ee4c156b49c67ff710ad91::hworm {
    struct HWORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWORM>(arg0, 6, b"HWORM", b"Halloween Worm", b"Token to celebrate de 2025 Halloween, crypto bull run start and changing lives period.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730574922896.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HWORM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWORM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

