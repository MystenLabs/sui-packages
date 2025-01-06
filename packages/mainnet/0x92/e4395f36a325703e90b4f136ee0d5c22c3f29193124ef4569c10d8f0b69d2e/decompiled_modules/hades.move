module 0x92e4395f36a325703e90b4f136ee0d5c22c3f29193124ef4569c10d8f0b69d2e::hades {
    struct HADES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HADES>(arg0, 6, b"HADES", x"e1bc8dceb9ceb4ceb7cf82206279205375694149", b"Hades was the son of the Titans Cronus and Rhea. Cronus was afraid that his children would overthrow him, so he ate each of them as soon as they were born. Only the youngest Zeus escaped the disaster because his mother Rhea replaced him with a stone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/10dfa9ec8a13632762d0a58551c5b7ec08fa513d6978_4ac4dc11b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HADES>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HADES>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

