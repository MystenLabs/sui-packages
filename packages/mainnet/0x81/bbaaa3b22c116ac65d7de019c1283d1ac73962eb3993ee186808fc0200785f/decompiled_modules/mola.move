module 0x81bbaaa3b22c116ac65d7de019c1283d1ac73962eb3993ee186808fc0200785f::mola {
    struct MOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLA>(arg0, 6, b"MOLA", b"MOLA SUI", b"MOLA SUI: Mini Game and Meme. Following the success of Fud on Sui, a series of other meme coin projects were born such as HSUI, SCB,..... $MOLA the newest descendant of the meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mola_Pixel_89ae7efc21.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

