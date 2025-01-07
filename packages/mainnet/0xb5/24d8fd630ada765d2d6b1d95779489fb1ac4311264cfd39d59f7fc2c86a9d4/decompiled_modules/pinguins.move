module 0xb524d8fd630ada765d2d6b1d95779489fb1ac4311264cfd39d59f7fc2c86a9d4::pinguins {
    struct PINGUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGUINS>(arg0, 6, b"PINGUINS", b"Pinguins", x"50696e6775696e7320776561727320616e206f63746f707573206861740a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_25_233000_593cc9de0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGUINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGUINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

