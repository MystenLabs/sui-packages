module 0x9ac342c14728ebd6ea1dfa7582c89ee84681230e98ee105c5e20c71c081ebf9c::nana {
    struct NANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANA>(arg0, 6, b"Nana", b"Nanalan", b"Small-scale adventures and of a three-year-old puppet girl named Mona in her grandmother Nana's backyard. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/add_0f1858fd53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

