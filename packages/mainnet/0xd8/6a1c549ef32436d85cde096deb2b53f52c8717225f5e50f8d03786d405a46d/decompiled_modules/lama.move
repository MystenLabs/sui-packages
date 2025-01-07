module 0xd86a1c549ef32436d85cde096deb2b53f52c8717225f5e50f8d03786d405a46d::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"LAMA", b"Lama", b"Combining Sui technology with the spirit of the Lama, we create a robust platform closely connected to its community. Explore Lama and experience a powerful and meaningful blockchain journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731044777203.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

