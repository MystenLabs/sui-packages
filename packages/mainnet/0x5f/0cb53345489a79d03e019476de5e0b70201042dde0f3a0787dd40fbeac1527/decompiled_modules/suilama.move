module 0x5f0cb53345489a79d03e019476de5e0b70201042dde0f3a0787dd40fbeac1527::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 6, b"SUILAMA", b"SUI LAMA", b"Suilama in the Sui Chain !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_512_512_bcfd8fd3e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

