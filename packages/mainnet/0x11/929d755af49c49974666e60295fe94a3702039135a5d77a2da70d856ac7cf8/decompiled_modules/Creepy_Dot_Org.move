module 0x11929d755af49c49974666e60295fe94a3702039135a5d77a2da70d856ac7cf8::Creepy_Dot_Org {
    struct CREEPY_DOT_ORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREEPY_DOT_ORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREEPY_DOT_ORG>(arg0, 9, b"CREEPY", b"Creepy Dot Org", b"so creepy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1930633311883317249/ywMq66aa_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREEPY_DOT_ORG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREEPY_DOT_ORG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

