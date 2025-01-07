module 0x60c7136ed62dce3503dba4bc2433bb4bb571e1181aa560e8350445c09329186c::uhave {
    struct UHAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHAVE>(arg0, 6, b"Uhave", b"U have to have", b"Do u have?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7594_fd6409db92.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UHAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

