module 0xa9189611eb95687ed9a562971d692b50d590063e420a75af488888691af1bd0a::muff {
    struct MUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUFF>(arg0, 6, b"MUFF", b"MUFFIE", b"My name is Muffie I like Emo This is dedicated to all the dead orphaned memes out there. If Emo was \"just a phase\" for you then you are a poser", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pepecum_Fem7_a96debd366.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

