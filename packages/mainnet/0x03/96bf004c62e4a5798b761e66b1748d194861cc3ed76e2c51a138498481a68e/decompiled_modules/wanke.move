module 0x396bf004c62e4a5798b761e66b1748d194861cc3ed76e2c51a138498481a68e::wanke {
    struct WANKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANKE>(arg0, 6, b"WANKE", b"WANKE SUI", b"Meet Wanke. The Retardiest one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7317_fa8e433f42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

