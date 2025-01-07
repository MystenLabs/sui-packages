module 0x43429e3aa2e358b3bd3174de7997339ce4dd74b4d1050bee52cf7f0c157cc75c::smood {
    struct SMOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOOD>(arg0, 6, b"SMOOD", b"SuperMoodeng", b"Our superhero flying moodeng coming to the rescue!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000128107_931324f256.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

