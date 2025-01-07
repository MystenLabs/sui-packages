module 0xa45d900621e5da1d49520ecd9f6a45d4c803d334c7467cbd648611cc21ce1e0c::dogai {
    struct DOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGAI>(arg0, 6, b"DOGAI", b"DogAI", b"#DogAi is soon to launch an AI crypto analysis platform, on SUI, helping finding new gems and early trends based on metrics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_204944_fb355388b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

