module 0xd418011c52f04080db21f632333325d85327e1ae5328a4f0bac15139f37670bf::moosui {
    struct MOOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSUI>(arg0, 6, b"Moosui", b"Moodeng on sui", b"Just Moodeng culture on Sui network , fanart of Moodeng and another Moo from Khao kheaw Zoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2868_a28c19db56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

