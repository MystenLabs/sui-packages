module 0x193f864cb739fc47f585407bae742a9f8f9bc8526cfac5477c153d5f3385b705::sland {
    struct SLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAND>(arg0, 6, b"SLAND", b"SUILAND", b"SuiLand the underwater city for all memes on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Me_cd3d9b592b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

