module 0x8eb78e52839175e579f0492ccd58be2bd56a983e5fd13a67febe8eeab5059f84::sroom {
    struct SROOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SROOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SROOM>(arg0, 6, b"SROOM", b"SroomAI", b"SroomAI DAO - the first AI hedge fund for AI projects investment on SUI. In a virtual psychedelic mushroom lab, AI-driven waifu scientists pioneer innovation of technology and magic fungi. The DAO specializes in exploring, cultivating, and trading unique virtual magic mushrooms, revolutionized virtual trippy culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058322_f892986783.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SROOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SROOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

