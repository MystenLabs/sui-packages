module 0x4a04ca6e8c8f5518ef710cc55d6368b23d426ba8d6aaa45a9208ee152e14cf4e::woj {
    struct WOJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJ>(arg0, 6, b"WOJ", b"Wojak", b"https://t.me/wojaksui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_03_17_03_4bca340125.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

