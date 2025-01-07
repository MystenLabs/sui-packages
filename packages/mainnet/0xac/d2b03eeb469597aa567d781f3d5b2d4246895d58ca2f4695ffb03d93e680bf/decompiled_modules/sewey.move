module 0xacd2b03eeb469597aa567d781f3d5b2d4246895d58ca2f4695ffb03d93e680bf::sewey {
    struct SEWEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEWEY>(arg0, 6, b"SEWEY", b"Sewey", b"Itz Sewey. Yu know, te blockchan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_Artwork_98520d8ac2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEWEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEWEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

