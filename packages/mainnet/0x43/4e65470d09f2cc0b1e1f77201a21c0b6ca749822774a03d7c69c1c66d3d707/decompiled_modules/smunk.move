module 0x434e65470d09f2cc0b1e1f77201a21c0b6ca749822774a03d7c69c1c66d3d707::smunk {
    struct SMUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUNK>(arg0, 6, b"SMUNK", b"MUNK ON SUI", b"SMUNK is more than just a meme coin. Our mission is to create a welcoming space where everyone can contribute, collaborate, and have fun together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_09_13_22_54_46_33fdc97e40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

