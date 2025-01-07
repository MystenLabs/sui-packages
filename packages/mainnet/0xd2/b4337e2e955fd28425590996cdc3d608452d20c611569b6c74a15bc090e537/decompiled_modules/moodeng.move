module 0xd2b4337e2e955fd28425590996cdc3d608452d20c611569b6c74a15bc090e537::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"Moodeng", b"Moo Deng", b"Moo Deng, a two-month-old female pygmy hippo whose name means \"bouncy pig,\" is causing a sensation online and drawing crowds to Thailand's Khao Kheow Open Zoo. Since her debut in July, visitor numbers have doubled.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0571_8aa361bf1e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

