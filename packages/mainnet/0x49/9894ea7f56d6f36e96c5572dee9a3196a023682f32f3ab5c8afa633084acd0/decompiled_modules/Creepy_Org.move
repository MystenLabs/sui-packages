module 0x499894ea7f56d6f36e96c5572dee9a3196a023682f32f3ab5c8afa633084acd0::Creepy_Org {
    struct CREEPY_ORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREEPY_ORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREEPY_ORG>(arg0, 9, b"CREEPY2", b"Creepy Org", b"creepy so creepy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1930633311883317249/ywMq66aa_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREEPY_ORG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREEPY_ORG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

