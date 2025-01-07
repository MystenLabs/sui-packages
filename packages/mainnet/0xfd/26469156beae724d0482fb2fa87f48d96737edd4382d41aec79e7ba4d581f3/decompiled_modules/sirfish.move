module 0xfd26469156beae724d0482fb2fa87f48d96737edd4382d41aec79e7ba4d581f3::sirfish {
    struct SIRFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRFISH>(arg0, 6, b"SIRFISH", b"Sir Fish", b"Sir Fish is good at saving people from deep trenches with his flawless trading style. But don't be mistaken. He is just a businessman with a fish head. He can't swim.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6078126473807512617_1_5c799ff307_bc680ad837.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIRFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

