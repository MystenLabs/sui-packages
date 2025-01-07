module 0x7d2cdbec5e5e6527120067f38448f2333e015207133a396059b1da61f319da0b::chui {
    struct CHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUI>(arg0, 6, b"CHUI", b"ChopSui", b"A cute little Blue Shiba named Chui eating Chop Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036463_047b6f02ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

