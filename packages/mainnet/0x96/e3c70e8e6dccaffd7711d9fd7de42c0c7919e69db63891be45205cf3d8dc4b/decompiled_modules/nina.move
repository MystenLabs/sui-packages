module 0x96e3c70e8e6dccaffd7711d9fd7de42c0c7919e69db63891be45205cf3d8dc4b::nina {
    struct NINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINA>(arg0, 6, b"NINA", b"Halo Nina", b"Ai agent Nina with Tsundere character \"It's not like Nina care about you or anything, but... fine, I'll help you. \"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_3_eddc7b507b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

