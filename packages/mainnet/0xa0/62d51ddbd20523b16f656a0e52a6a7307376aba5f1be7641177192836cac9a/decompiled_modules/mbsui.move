module 0xa062d51ddbd20523b16f656a0e52a6a7307376aba5f1be7641177192836cac9a::mbsui {
    struct MBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBSUI>(arg0, 6, b"Mbsui", b"Moonbunnysui ", x"536f6d6f7320756e206d656d652064697665727469646f20636f6e20656c206d65726f206f626a657469766f206465206c6c656761722061206c61206c756e612c20636164612076657a2071756520636f6d706c6574656d6f73206869746f732c207175656d6172656d6f7320756e2025206465206e75657374726f20746f74616c20737570706c792c20686173746120726564756369726c6f2061206dc3a17320646520756e203530252e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730671725467.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

