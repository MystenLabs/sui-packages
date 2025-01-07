module 0xcf78b1554124a5548449f6b289b2db0527c50c542189201e203604b95f119b08::heck {
    struct HECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HECK>(arg0, 6, b"HECK", b"Hecklefish", b"Conspiracy Theorist, skeptic, and sharp-tongued sidekick of Andrew Gentile on the YouTube show *The Why Files*, he delivers biting humor and relentless doubt, dissecting each mystery with a mix of irreverence and sarcasm that keeps the audience both entertained and questioning everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hecklefish_0c14b815f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HECK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HECK>>(v1);
    }

    // decompiled from Move bytecode v6
}

