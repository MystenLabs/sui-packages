module 0x73f561a62cf8b35512a225059d2db69ef57a8be6c7c060ba4eeba5def7898bf2::brony {
    struct BRONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRONY>(arg0, 6, b"BRONY", b"Brony Alliance", x"42726f6e7920416c6c69616e636520697320616c6c2061626f7574206275696c64696e672061206c6f6e670a7465726d207375737461696e61626c65206d656d652064726976656e20636f6d6d756e6974790a4c657473206272696e67206261636b20746865206e6f7374616c676961206f662042726f6e69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054469_f0ff5c8738.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

