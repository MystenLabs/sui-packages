module 0x528f27287fe10bef0c1680cff36f2e1314e8214612a0d447e67a576ad796bbbb::mcdeng {
    struct MCDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDENG>(arg0, 6, b"MCDENG", b"MC DENG", b"FAN #MCDENG TOKEN MADE BY #MOODENG GANG in #SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deng_2ac2cfbe46.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

