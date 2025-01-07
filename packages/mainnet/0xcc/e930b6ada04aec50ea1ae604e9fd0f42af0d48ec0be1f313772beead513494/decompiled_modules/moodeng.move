module 0xcce930b6ada04aec50ea1ae604e9fd0f42af0d48ec0be1f313772beead513494::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"Moodeng", b"moodeng", b"Moodeng on eth,managed by community ,lp burntand 0 tax", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1341ad6b7af0de553d3044933f27c74bb96d2b88e3dee8b960f05fa7cc0559e2_0_6dc873fa45.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

