module 0xd76833790c313c0a530bd73d3785f3b8263f8ceeed0c2b1e7e8ed6ebdf913ac5::jui {
    struct JUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUI>(arg0, 6, b"JUI", b"JUISUI", b"What a fresh juicy juisui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_cf93584758.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

