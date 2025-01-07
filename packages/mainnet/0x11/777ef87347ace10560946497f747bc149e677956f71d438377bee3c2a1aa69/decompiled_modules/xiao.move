module 0x11777ef87347ace10560946497f747bc149e677956f71d438377bee3c2a1aa69::xiao {
    struct XIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAO>(arg0, 6, b"XIAO", b"xiaojie", x"5468652066697273742063757465737420636174206f6e205355492e0a0a5869616f6a6965206973206375746520205869616f6a69652069732066616d6f757320205869616f6a696520697320736d6f6c20205869616f6a69652069732066617368696f6e61626c6520203a330a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_23_57_52_a49a13aa5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

