module 0xfc4bf13723a8ec9e0d0dee2940062e30e9b0a2ce9fce661f28dde820ac5dd4af::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"Maga Minions", b"Inspired by Donald Trump's historic election campaigns, MAGA MINIONS is more than just a cryptocurrency  its a symbol of strength, freedom, and humor for the digital age.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/maga_76e8a514e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

