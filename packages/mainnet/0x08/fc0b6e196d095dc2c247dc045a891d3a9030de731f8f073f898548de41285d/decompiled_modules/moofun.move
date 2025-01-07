module 0x8fc0b6e196d095dc2c247dc045a891d3a9030de731f8f073f898548de41285d::moofun {
    struct MOOFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOFUN>(arg0, 6, b"MOOFUN", b"MOODENG FUN HIPPO", b"Just Moodeng Viral Hippo always fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moodeng_91e48edaa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

