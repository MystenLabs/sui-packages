module 0x83e8b31841fccd4a73776fc43c64e01659710978ba109c38ae8563e0272218cf::rambodeng {
    struct RAMBODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMBODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMBODENG>(arg0, 6, b"RAMBODENG", b"RAMBO DENG", b"Rumour has it that Moo Deng's mother, Jonah Dang, had an affair with Rambo Deng. Upon word getting out, Rambo allegedly fled to the jungle. Our mission... to find Rambo and bring him home safely, reuniting him with Moo Deng and fellow Deng's.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rambo_deng_92c24ee07e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMBODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAMBODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

