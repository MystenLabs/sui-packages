module 0xa50cf6728abeadc525cd6223e715893ece2ca44d05a2f91ae950c0661e48b948::nunu {
    struct NUNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUNU>(arg0, 6, b"NUNU", b"NUNU SUI", b"NUNU TOP MEME ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/88ffbf4f2676127c45b70779e3d91766_0b9c62d390.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

