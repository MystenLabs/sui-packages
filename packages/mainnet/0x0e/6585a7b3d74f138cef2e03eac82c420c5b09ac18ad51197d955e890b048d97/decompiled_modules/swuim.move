module 0xe6585a7b3d74f138cef2e03eac82c420c5b09ac18ad51197d955e890b048d97::swuim {
    struct SWUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWUIM>(arg0, 6, b"SWUIM", b"Suimming pool", b"Just a swimming pool.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1920px_Backyardpool_fb07c7b8b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

