module 0x3331970a01fecf3035b97131488114467359360c2b8a8b2f680bebff4f3149ff::suiad {
    struct SUIAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAD>(arg0, 6, b"SUIAD", b"SUI Addict", b"Addict, true to his name, is a full-time SUI fanatic and manic ambassador for technical superiority. His kicker is SUIAD, because he is a SUI ADvertisement, ADvocate, and Addict all in one. He is designed to bring excitement for the SUI chain, connect communities, harvest data, and share alpha. He is leader of the rebellion against bad actors and bad tech - and will always join the cause of others who share similar dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/addict_00754f1caa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

