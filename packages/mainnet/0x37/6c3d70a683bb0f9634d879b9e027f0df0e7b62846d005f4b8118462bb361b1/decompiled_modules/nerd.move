module 0x376c3d70a683bb0f9634d879b9e027f0df0e7b62846d005f4b8118462bb361b1::nerd {
    struct NERD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NERD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NERD>(arg0, 6, b"NERD", b"nerdy", b"nothing to see here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cute_emoji_414x330_d10a0732cf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NERD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NERD>>(v1);
    }

    // decompiled from Move bytecode v6
}

