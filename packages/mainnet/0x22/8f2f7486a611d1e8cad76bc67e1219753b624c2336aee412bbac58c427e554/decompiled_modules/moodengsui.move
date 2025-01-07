module 0x228f2f7486a611d1e8cad76bc67e1219753b624c2336aee412bbac58c427e554::moodengsui {
    struct MOODENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENGSUI>(arg0, 6, b"MOODENGSUI", b"MOODENG", b"MEME MOODENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ly5bqp_eb8614af66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

