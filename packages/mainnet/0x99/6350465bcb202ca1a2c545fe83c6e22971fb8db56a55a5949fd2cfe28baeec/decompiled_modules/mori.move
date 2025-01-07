module 0x996350465bcb202ca1a2c545fe83c6e22971fb8db56a55a5949fd2cfe28baeec::mori {
    struct MORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORI>(arg0, 6, b"MORI", b"Mordecai & Rigby", b"Mordecai & Rigby Memecoin $MORI is a playful and nostalgic memecoin inspired by the dynamic duo from Regular Show.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039055_c0b8419cb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

