module 0xa9c90bf6d579283988b6e6365a6a78e6013080888a3b0c2ee3d0853e0e744599::yuge {
    struct YUGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUGE>(arg0, 6, b"YUGE", b"YUGE you know b", b"get a yuge bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_WX_2e_fc997bff9f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

