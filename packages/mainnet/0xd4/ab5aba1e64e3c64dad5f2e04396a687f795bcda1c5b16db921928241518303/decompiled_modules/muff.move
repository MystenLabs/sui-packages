module 0xd4ab5aba1e64e3c64dad5f2e04396a687f795bcda1c5b16db921928241518303::muff {
    struct MUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUFF>(arg0, 6, b"MUFF", b"MUFFIE", b"My name is Muffie I like Emo This is my first coin and is dedicated to all the Dead orphaned Memes out there and Ai dedicated to emo shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Robot3_651f4988ed.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

