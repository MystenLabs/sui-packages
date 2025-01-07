module 0x86ceacb0cf63eda35a734fc4fbe8ab1f75e34b3e3ee93447e9a7e865e6a5d436::sux {
    struct SUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUX>(arg0, 6, b"Sux", b"Hop Aggravator", b"It works just try again. Refresh. Restart. Refresh.Close apps. Refresh.Restart.Refresh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8877_b7fd116f56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

