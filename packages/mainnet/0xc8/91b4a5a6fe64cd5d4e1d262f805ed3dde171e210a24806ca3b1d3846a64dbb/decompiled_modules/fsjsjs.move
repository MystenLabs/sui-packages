module 0xc891b4a5a6fe64cd5d4e1d262f805ed3dde171e210a24806ca3b1d3846a64dbb::fsjsjs {
    struct FSJSJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSJSJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSJSJS>(arg0, 6, b"Fsjsjs", b"Test dont buy", b"dont buy - join tg for ofc launch - @superleague_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5893415976404371874_99_7b26036f58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSJSJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSJSJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

