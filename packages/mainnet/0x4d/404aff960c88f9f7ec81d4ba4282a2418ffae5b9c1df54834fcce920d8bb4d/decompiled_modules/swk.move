module 0x4d404aff960c88f9f7ec81d4ba4282a2418ffae5b9c1df54834fcce920d8bb4d::swk {
    struct SWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWK>(arg0, 6, b"SWK", b"SuiWuWuKong", b"Token wukong on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7098_6438504ad5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

