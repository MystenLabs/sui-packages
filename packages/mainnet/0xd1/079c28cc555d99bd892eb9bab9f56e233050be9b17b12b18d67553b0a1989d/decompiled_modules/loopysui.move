module 0xd1079c28cc555d99bd892eb9bab9f56e233050be9b17b12b18d67553b0a1989d::loopysui {
    struct LOOPYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPYSUI>(arg0, 6, b"LOOPYSUI", b"LOOPY", b"cute loopy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x7ebb136224ddabea010f4ee3261e66c19921d76f73b94a2f979907b459c16ae2_loopy_loopy_43b9143688.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

