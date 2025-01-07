module 0x8accbe253bc14e00ef52a70a2ffe5f32367e5b85533c30d7d3cf31298ae0f826::toad {
    struct TOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAD>(arg0, 6, b"TOAD", b"The Obviously Autistic Doge", b"Invest in $TOAD today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_4c0ea3b581.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

