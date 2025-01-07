module 0x4aff07c79447fcc98830b9c6a6711666646abb8e1a47ce2bf14661f329006610::botipop {
    struct BOTIPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTIPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTIPOP>(arg0, 6, b"BOTIPOP", b"Botipop", b"Botipop is a spooky buntal fish to injure sui tissue that is hot at the moment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036834_ff89141ab1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTIPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTIPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

