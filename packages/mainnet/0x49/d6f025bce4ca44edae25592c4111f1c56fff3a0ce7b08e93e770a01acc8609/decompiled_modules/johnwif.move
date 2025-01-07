module 0x49d6f025bce4ca44edae25592c4111f1c56fff3a0ce7b08e93e770a01acc8609::johnwif {
    struct JOHNWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOHNWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNWIF>(arg0, 6, b"JohnWif", b"JOHN WIF HAT", b"Don`t fuck with his dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_12_22_27_46_5fcf740497.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOHNWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

