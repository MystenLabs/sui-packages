module 0xf573973622b710176422ea6ced6a12a78932f2b9ca17224d15507d5bb56b23d7::mrug {
    struct MRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRUG>(arg0, 6, b"MRUG", b"Meow Rug", b"MEEEEOOOWWWWWWRRRRUUUUGGGGGGG!!!!! Its a RUGG!!!!!! No website!!! Just TG and X only!!! RUGG!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_07_21_23_49_9139339699.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

