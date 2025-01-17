module 0x9507fb2554d2b4de8e41f7dfec4b232c4a25c9640dab7fdd9d916853dfe5f18d::aahh {
    struct AAHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAHH>(arg0, 6, b"AAHH", b"Alien Cat", b"AAHHHHHHHHHHHHHHHHHHHH, da strongest weapon in da galaxy, fr fr!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_221605_904_fda65fc4f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

