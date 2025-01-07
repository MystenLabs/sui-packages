module 0x36417cb60aca1464f84ae39d557924e72ab26d40fd537a6c5d448d51c32a8595::bube {
    struct BUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBE>(arg0, 6, b"BUBE", b"Bubbles", b"In the BubbleVerse, tokens represent fragile, shimmering bubbles. Each bubble holds value, but can burst at any moment, releasing its value to the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bube_fb2536d1cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

