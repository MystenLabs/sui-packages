module 0xf3ccecf7fcf287618378dde54aa4f14ed91a9fae9f72677fac254c73a47d5f03::moodengsui {
    struct MOODENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENGSUI>(arg0, 6, b"MOODENGSUI", b"MOODENG", b"MOODENG on SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4370_6cdc2dd6a5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

