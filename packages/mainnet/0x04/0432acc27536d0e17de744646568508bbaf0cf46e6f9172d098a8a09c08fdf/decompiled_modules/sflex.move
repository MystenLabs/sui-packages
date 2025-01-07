module 0x40432acc27536d0e17de744646568508bbaf0cf46e6f9172d098a8a09c08fdf::sflex {
    struct SFLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLEX>(arg0, 6, b"Sflex", b"Suuflex", b"See what's next!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiflex_adff0f09fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

