module 0xb1348a8aec43a2f24a400f893d66840fcbeecb5e48d225250d36c97f3db6d367::miaw {
    struct MIAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAW>(arg0, 6, b"MIAW", b"Kitty", b"cutiest and funniest kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_21_05_30_1bdc118b75.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

