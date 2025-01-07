module 0xeed955926bc66b4525b1017959ddfef0f4a8e053ea8dd2b4edb4f52c70443209::muff {
    struct MUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUFF>(arg0, 6, b"Muff", b"Muffie", b"This is a place for dead orphaned memes emo Ai etc. If Emo was \"just a phase\" then youre a poser", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4352_e845d6d9af.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

