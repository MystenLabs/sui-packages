module 0x5ddb9fe3bf5349f6bc7a57235e2034926d856d4cc502312805cf2043d159798::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"OG MELANIA MEMES SUI", b"Melania memes are digital collectibles intended to function as an expression of support for and engagement with the values embodied by the symbol MELANIA. and the associated artwork, and are not intended to be, or to be the subject of, an investment opportunity, investment contract, or security of any type. https://melaniatrumpsui.org/ is not political and has nothing to do with any political campaign or any political office or governmental agency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_db2eef358c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

