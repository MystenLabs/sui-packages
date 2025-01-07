module 0xc2abf10e6472c8f29ea69a145f83ff929bacb9d6e62a9120274cc1a29efdb3ff::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 6, b"MABA", b"Make America Based Again", x"456c6f6e2026205472756d702077696c6c207361766520416d6572696361210a0a0a68747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f31383432373439383339303535393632323833", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mautache_08e707033e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

