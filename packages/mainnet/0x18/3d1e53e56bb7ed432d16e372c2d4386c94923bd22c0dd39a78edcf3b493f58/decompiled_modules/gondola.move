module 0x183d1e53e56bb7ed432d16e372c2d4386c94923bd22c0dd39a78edcf3b493f58::gondola {
    struct GONDOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONDOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONDOLA>(arg0, 6, b"GONDOLA", b"Gondola ON SUI", b"Gondola, the cultural icon in high-waisted pants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9l_OBG_Dwd_400x400_894e08b8ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONDOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONDOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

