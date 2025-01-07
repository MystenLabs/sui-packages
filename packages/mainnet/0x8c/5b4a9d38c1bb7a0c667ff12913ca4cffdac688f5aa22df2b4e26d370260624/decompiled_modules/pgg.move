module 0x8c5b4a9d38c1bb7a0c667ff12913ca4cffdac688f5aa22df2b4e26d370260624::pgg {
    struct PGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGG>(arg0, 9, b"PGG", b"PiggiLand", b"MomoAI Last Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9c06c7a-0b45-48cd-9e2c-1f6b724f350c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

