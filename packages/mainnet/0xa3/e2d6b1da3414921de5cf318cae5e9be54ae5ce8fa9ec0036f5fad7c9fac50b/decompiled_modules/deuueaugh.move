module 0xa3e2d6b1da3414921de5cf318cae5e9be54ae5ce8fa9ec0036f5fad7c9fac50b::deuueaugh {
    struct DEUUEAUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEUUEAUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEUUEAUGH>(arg0, 6, b"DEUUEAUGH", b"Deuueaugh", b"Storyboards of the \"DEUUEAUGH\" scene from the episode \"Something Smells.\" (2000)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0229_f42bba451f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEUUEAUGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEUUEAUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

