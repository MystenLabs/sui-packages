module 0xfa911456e07e89b92f9213d81be488238739cc2c4cb4112dbcd00aef1bf09ddc::mimi {
    struct MIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMI>(arg0, 6, b"Mimi", b"Hami", b"Just a hami meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BB_1n_OG_Ba_75f8939391.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

