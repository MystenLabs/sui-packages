module 0x5de3b6ee3fc7851fd7937507f19ea73e3a4cb1093a47acff37ed8d52949d79b::tish {
    struct TISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISH>(arg0, 6, b"TISH", b"ONLYSHIT", b"tishey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/108015006_gettyimages_590062982_b47a6ec392.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

