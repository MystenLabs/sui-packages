module 0x4e4e52d578eba000f0f13bbedff2589bf4ad6f4a7405d30a402c31fdd1edbb0d::bbtt {
    struct BBTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBTT>(arg0, 6, b"BBTT", b"Baby Turtle", b"go go go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_a93a0ce540.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

