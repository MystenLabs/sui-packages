module 0x21a9c059bb6e07f17f43d79258e7de01718b5992b6da25147c3f9f2ce499b673::goji {
    struct GOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOJI>(arg0, 6, b"GOJI", b"GOJI SUI", x"546865204375746573742044696e6f204f6e2054686520496e7465726e65740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W7_S8m_Xjw_400x400_ec5be746f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

