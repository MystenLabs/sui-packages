module 0x301348c027ae96c0f6d862efe549d451ac2471bef170a0ea3562352ed4fabf40::munk {
    struct MUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNK>(arg0, 6, b"MUNK", b"SUI MUNK", b"MUNK is more than just a meme coin. Our mission is to create a welcoming space where everyone can contribute, collaborate, and have fun together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_09_13_22_54_46_7b1d9b3743.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

