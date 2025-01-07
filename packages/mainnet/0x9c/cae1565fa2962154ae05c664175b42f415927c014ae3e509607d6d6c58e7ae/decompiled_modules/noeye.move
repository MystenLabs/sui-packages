module 0x9ccae1565fa2962154ae05c664175b42f415927c014ae3e509607d6d6c58e7ae::noeye {
    struct NOEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOEYE>(arg0, 6, b"NOEYE", b"no eyed cat", b"A blind cat wandered alone, searching for the warmth of a friend who vanished. Each day felt emptier, her heart aching.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/no_eyes_cat_2ad86a63b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

