module 0xbb30053d5e8202b62116bafa91a3d7e22a0e9af05467395b33fe7fb5efb88f3d::mrug {
    struct MRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRUG>(arg0, 6, b"MRUG", b"Meow Rug", b"MEEEEOOOWWWWWWRRRRUUUUGGGGGGG!!!!! Its a RUGG!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mrug_f2a0f21c0f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

