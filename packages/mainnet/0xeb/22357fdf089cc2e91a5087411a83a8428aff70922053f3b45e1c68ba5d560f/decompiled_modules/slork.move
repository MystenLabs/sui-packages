module 0xeb22357fdf089cc2e91a5087411a83a8428aff70922053f3b45e1c68ba5d560f::slork {
    struct SLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLORK>(arg0, 6, b"SLORK", b"SLORK FATHER SLERF", b"SLORK IS FATHER SLERF ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3608_cba0caa852.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

