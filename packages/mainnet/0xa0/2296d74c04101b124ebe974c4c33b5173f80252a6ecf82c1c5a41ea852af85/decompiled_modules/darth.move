module 0xa02296d74c04101b124ebe974c4c33b5173f80252a6ecf82c1c5a41ea852af85::darth {
    struct DARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARTH>(arg0, 6, b"DARTH", b"DARTH SUIDER", b"The Dark Side of the Memecoin Galaxy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/27e78fef_3292_487d_8b55_010e6bdf1b93_48f5cfd612.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

