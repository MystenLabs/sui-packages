module 0xa3d61d53509ebcc297209d9f5dcd79f3bd42d4e0b2279c1c0881e8143dd5b0b6::snailspace {
    struct SNAILSPACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAILSPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAILSPACE>(arg0, 6, b"Snailspace", b"snail's pace", b"snail's pace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_07_19_fad3faba7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAILSPACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAILSPACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

