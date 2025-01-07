module 0xb737e8a062c3555189e7c7619ac334d95ceee238f422f9e4c76c13d212a0f90b::neuraai {
    struct NEURAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURAAI>(arg0, 6, b"NeuraAI", b"Neura", b"Making the ordinary things become Extra Ordinary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_1_dda13fad0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

