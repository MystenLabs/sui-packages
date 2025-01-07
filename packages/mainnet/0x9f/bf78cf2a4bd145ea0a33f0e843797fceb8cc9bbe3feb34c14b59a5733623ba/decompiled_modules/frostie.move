module 0x9fbf78cf2a4bd145ea0a33f0e843797fceb8cc9bbe3feb34c14b59a5733623ba::frostie {
    struct FROSTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTIE>(arg0, 6, b"Frostie", b"Frostie Bite", b"Frostie Bite, the adopted dog of the Boy's Club and a friend to all. Frostie is meant in Sui chain where he will have its own adventures. With each step, he uncovers new mysteries and forges unforgettable friendships, all while navigating the enchanting landscapes of his unique realm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fr_dcf47843bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

